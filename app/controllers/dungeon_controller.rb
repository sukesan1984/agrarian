class DungeonController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def enter
    @dungeon_id = params[:dungeon_id]
    @dungeon_entity = @dungeon_entitiy_factory.create_by_player_id_and_dungeon_id(@player_character.id, @dungeon_id)
    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end
    dungeon_entrance_service = Dungeon::DungeonEntranceService.new(@dungeon_entity)
    dungeon_entrance_service.enter()
  end

  def actions
    @dungeon_entity = @dungeon_entitiy_factory.create_by_player_id(@player_character.id)
    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end
  end

  # ダンジョン探索
  def search
    @dungeon_entity = @dungeon_entitiy_factory.create_by_player_id(@player_character.id)
    if @dungeon_entity.nil?
      redirect_to '/'
      return
    end
    dungeon_searching_service = Dungeon::DungeonSearchingService.new(@dungeon_entity)
    dungeon_searching_service.search
  end

  # 階段をおりる
  def ascend
    @dungeon_entity = @dungeon_entitiy_factory.create_by_player_id(@player_character.id) 
    if @dungeon_entity.nil?
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

  def set_factories
    @equipment_entity_factory = EquipmentEntityFactory.new
    @equipped_entity_factory = EquippedEntityFactory.new(@equipment_entity_factory)
    @equipped_list_entity_factory = EquippedListEntityFactory.new(@equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(@equipped_list_entity_factory)
    @dungeon_entitiy_factory = DungeonEntityFactory.new
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end
