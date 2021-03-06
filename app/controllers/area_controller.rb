class AreaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character
  before_action :set_host

  def index
  end

  def show
    @area_node_id = params[:id].to_i

    dungeon_entity = @dungeon_entitiy_factory.create_by_player_id(@player_character.id)

    if dungeon_entity && dungeon_entity.is_entering_dungeon
      redirect_to '/dungeon/actions'
      return
    end

    @current = @area_service_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)
    if @current.is_nil
      redirect_to '/areas/not_found'
      return
    end

    # 今の位置からその位置に移動できるかのチェック
    @current_target_routes = @area_service_factory.build_target_routes_by_player_id(@player_character.id)

    user_area = UserArea.get_or_create(@player_character.id)

    #移動するときだけ
    if user_area.area_node_id != @area_node_id
      logger.debug('room exit and enter')
      # 今いる場所のroomから抜ける
      RoomEntranceService.exit(user_area.area_node_id, @player_character.id)
      # 新しいroomに入る
      RoomEntranceService.enter(@area_node_id, @player_character.id)
    end

    # 今いる位置からの移動できる場所 or 今いる位置
    can_move_list = @current_target_routes.map { |target| target.area_node.id }
    can_move_list.push user_area.area_node_id
    unless can_move_list.include?(@area_node_id)
      redirect_to '/areas/cant_move'
      return
    end

    chat_room = ChatRoom.create_or_find(@area_node_id)
    # TODO: 人が多くなったら数絞るとかする。
    player_ids = chat_room.player_ids
    @members = @player_character_factory.build_by_player_ids(player_ids)

    # その位置固有のアクションの実行
    @current.execute

    @can_move_to_next = @current.can_move_to_next

    @target_routes = @area_service_factory.build_target_routes_by_area_node_id_and_player_id(@current.area_node.id, @player_character.id)

    user_area.area_node_id = @area_node_id
    user_area.save

    # そのエリアに落ちてるアイテム
    thrown_items = ThrownItem.where(area_node_id: @area_node_id)
                    .select(&:is_valid)
    @item_entities = @item_entity_factory.build_by_thrown_items(thrown_items)
    @soldier_characters = @soldier_character_factory.build_party_by_player_id(@player_character.id)
  end

  def not_found
  end

  def cant_move
  end

  private

  def set_factories
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    @soldier_character_factory = SoldierCharacterFactory.new(equipped_list_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_entity_factory)
    @resource_service_action_factory = ResourceActionServiceFactory.new(@player_character_factory)
    @resource_service_factory = ResourceServiceFactory.new
    area_node_factory = AreaNodeFactory.new
    @area_service_factory = AreaServiceFactory.new(@player_character_factory, @resource_service_factory, @resource_service_action_factory, Battle::BattleEncounterFactory.new(@player_character_factory, area_node_factory))
    user_item_factory = UserItemFactory.new
    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(user_item_factory)
    quest_entity_factory = Quest::QuestEntityFactory.new(@player_character_factory, quest_condition_entity_factory)
    @item_entity_factory = ItemEntityFactory.new(@player_character_factory, user_item_factory, quest_entity_factory, equipment_entity_factory)

    @dungeon_entitiy_factory = DungeonEntityFactory.new
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end

  def set_host
    if Rails.env == 'production'
      @host = 'agrarian.jp:3001'
    else
      @host = 'localhost:3000'
    end
  end
end

