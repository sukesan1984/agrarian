class BattleController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories

  def index
    @area_node_id = params[:area_node_id]
    @turn_count = params[:turn_count]

    # player
    player_character = @player_character_factory.build_by_user_id(current_user.id)

    # 移動先のリストを表示するため
    @current = @area_service_factory.build_by_area_node_id_and_player_id(@area_node_id, player_character.id)
    @target_routes = @area_service_factory.build_target_routes_by_area_node_id_and_player_id(@area_node_id, player_character.id)

    # デスペナルティの生成
    user_area = UserArea.get_or_create(player_character.id)
    @dungeon_entity = @dungeon_entity_factory.create_by_player_id(player_character.id)
    @death_penalty = DeathPenalty.new(player_character, user_area, @dungeon_entity)

    # ユーザーが遭遇してる敵を取得する
    user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: player_character.id)

    if user_encounter_enemy_group.enemy_group_id == 0
      render template: 'battle/no_enemy'
      return
    end

    # バトルの準備をする
    unit_list_a = []
    unit_list_b = []

    enemy_instances = EnemyInstanceFactory::get_by_enemy_group_id(user_encounter_enemy_group.enemy_group_id)

    enemy_instances.each do |enemy_instance|
      unit_list_a.push(Entity::Battle::UnitEntity.new(@enemy_character_factory.build_by_enemy_instance(player_character.id, enemy_instance)))
    end

    unit_list_b.push(Entity::Battle::UnitEntity.new(player_character))

    soldier_characters = @soldier_character_factory.build_party_by_player_id(player_character.id)

    soldier_characters.each do |soldier_character|
      unit_list_b.push(Entity::Battle::UnitEntity.new(soldier_character))
    end

    executor = Battle::Executor.new
    party_a = Entity::Battle::PartyEntity.new(unit_list_a, 'モンスターたち')
    party_b = Entity::Battle::PartyEntity.new(unit_list_b, '俺のパーティ')

    @result = executor.do_battle(party_a, party_b, @turn_count)

    # サービスの仕事だ
    begin
      ActiveRecord::Base.transaction do
        if @result.is_draw
          party_a.save!
          party_b.save!
          return
        end

        # 敵が勝利した
        if @result.is_winner(party_a)
          @death_penalty.execute
          @death_penalty.save!
          # この辺refactor
          party_a.save!
          party_b.save!
        else
          @battle_end = Battle::End.new(party_b, party_a, player_character)
          @battle_end.give_rails
          @battle_end.give_exp
          @battle_end.give_items
          @battle_end.save!
          # この辺refactor
          party_a.save!
        end

        # TODO: 後で移す
        user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: player_character.id)
        # 自分だけの時は消す 
        if UserEncounterEnemyGroup.where(enemy_group_id: user_encounter_enemy_group.enemy_group_id).count == 1
          EnemyGroup.delete_all(id: user_encounter_enemy_group.enemy_group_id)
          enemy_instances = EnemyInstance.where(enemy_group_id: user_encounter_enemy_group.enemy_group_id)
          enemy_instances.each(&:destroy)
        end
        user_encounter_enemy_group.enemy_group_id = 0
        user_encounter_enemy_group.save!
      end
    rescue => e
      raise e
    end
  end

  def escape
    @area_node_id = params[:area_node_id]
    battle_escape_service = Battle::Escape.new
    player_character = @player_character_factory.build_by_user_id(current_user.id)
    is_success_to_escape = battle_escape_service.execute(player_character.id)

    unless is_success_to_escape
      redirect_to('/battle/' + @area_node_id.to_s + '/1')
      return
    end
    @current = @area_service_factory.build_by_area_node_id_and_player_id(@area_node_id, player_character.id)

    @dungeon_entity = @dungeon_entity_factory.create_by_player_id(player_character.id)

    @target_routes = @area_service_factory.build_target_routes_by_area_node_id_and_player_id(@area_node_id, player_character.id)
  end

  def set_factories
    # factory
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_entity_factory)

    @soldier_character_factory = SoldierCharacterFactory.new(equipped_list_entity_factory)

    item_lottery_component_factory = ItemLotteryComponentFactory.new
    user_item_factory = UserItemFactory.new()

    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(user_item_factory)
    quest_entity_factory = Quest::QuestEntityFactory.new(@player_character_factory, quest_condition_entity_factory)
    item_entity_factory = ItemEntityFactory.new(@player_character_factory, user_item_factory, quest_entity_factory, equipment_entity_factory)
    @enemy_character_factory = EnemyCharacterFactory.new(item_lottery_component_factory, item_entity_factory)

    resource_service_action_factory = ResourceActionServiceFactory.new(@player_character_factory)
    resource_service_factory = ResourceServiceFactory.new
    area_node_factory = AreaNodeFactory.new
    @area_service_factory = AreaServiceFactory.new(@player_character_factory, resource_service_factory, resource_service_action_factory, Battle::BattleEncounterFactory.new(@player_character_factory, area_node_factory))

    @dungeon_entity_factory = DungeonEntityFactory.new

  end
end

