class DungeonController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def enter
    @dungeon_id = params[:dungeon_id]
    @dungeon_entity = @dungeon_entity_factory.create_by_player_id_and_dungeon_id(@player_character.id, @dungeon_id)
    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end

    @area_node_id = UserArea.get_current_or_create(@player_character.id)
    battle_encounter_service = @battle_encounter_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)
    @current_encounter = battle_encounter_service.get_current_encounter

    if @current_encounter[:is_encount]
      redirect_to '/'
      return 
    end

    dungeon_entrance_service = Dungeon::DungeonEntranceService.new(@dungeon_entity)
    dungeon_entrance_service.enter()
  end

  # 行動リストを取得する
  def actions
    @dungeon_entity = @dungeon_entity_factory.create_by_player_id(@player_character.id)
    @area_node_id = UserArea.get_current_or_create(@player_character.id)
    battle_encounter_service = @battle_encounter_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)
    @current_encounter = battle_encounter_service.get_current_encounter

    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end
  end

  # ダンジョン探索
  def search
    @dungeon_entity = @dungeon_entity_factory.create_by_player_id(@player_character.id)
    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end

    @area_node_id = UserArea.get_current_or_create(@player_character.id)
    battle_encounter_service = @battle_encounter_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)

    dungeon_searching_service = Dungeon::DungeonSearchingService.new(@dungeon_entity, battle_encounter_service)
    @current_encounter = dungeon_searching_service.search
  end

  # 階段をおりる
  def ascend
    @dungeon_entity = @dungeon_entity_factory.create_by_player_id(@player_character.id) 
    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end

    @area_node_id = UserArea.get_current_or_create(@player_character.id)
    battle_encounter_service = @battle_encounter_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)
    @current_encounter = battle_encounter_service.get_current_encounter

    if @current_encounter[:is_encount]
      redirect_to '/'
      return 
    end

    dungeon_ascending_service = Dungeon::DungeonAscendingService.new(@dungeon_entity)
    dungeon_ascending_service.ascend

    if !@dungeon_entity.is_entering_dungeon
      redirect_to '/'
      return
    end
  end

  # 脱出する
  # 将来的には簡単に脱出できなくしてもいいかもしれない
  def escape
    @dungeon_entity = @dungeon_entity_factory.create_by_player_id(@player_character.id) 
    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end

    @area_node_id = UserArea.get_current_or_create(@player_character.id)
    battle_encounter_service = @battle_encounter_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)

    @current_encounter = battle_encounter_service.get_current_encounter
    if @current_encounter[:is_encount]
      redirect_to '/'
      return 
    end

    dungeon_escaping_service = Dungeon::DungeonEscapingService.new(@dungeon_entity)
    dungeon_escaping_service.escape()
    redirect_to '/'
  end

  def set_factories
    @equipment_entity_factory = EquipmentEntityFactory.new
    @equipped_entity_factory = EquippedEntityFactory.new(@equipment_entity_factory)
    @equipped_list_entity_factory = EquippedListEntityFactory.new(@equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(@equipped_list_entity_factory)
    @dungeon_entity_factory = DungeonEntityFactory.new

    area_node_factory = AreaNodeFactory.new
    @battle_encounter_factory = Battle::BattleEncounterFactory.new(@player_character_factory, area_node_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end
