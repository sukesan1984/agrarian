class DungeonController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def enter
    @dungeon_id = params[:dungeon_id]
    dungeon = Dungeon.find_by(id: @dungeon_id)
    if dungeon.nil?
      fail "dungeon is not found: #{@dungeon_id}"
    end
    
    user_dungeon = UserDungeon.find_or_new(@player_character.id, @dungeon_id)
    dungeon_entrance_service = Dungeon::DungeonEntranceService.new(user_dungeon, dungeon)
    dungeon_entrance_service.enter()
  end

  def actions
    # 現在入ってるダンジョンを取得する
    user_dungeon = UserDungeon.find_by(player_id: @player_character.id)
  end

  # ダンジョン探索
  def search
    @user_dungeon = UserDungeon.find_by(player_id: @player_character.id)
    if @user_dungeon.nil?
      fail "user is not entering dungeon"
    end

    dungeon = Dungeon.find_by(id: @user_dungeon.id)
    if dungeon.nil?
      fail "dungeon is not found: #{@user_dungeon.id}"
    end
    dungeon_searching_service = Dungeon::DungeonSearchingService.new(@user_dungeon, dungeon)
    dungeon_searching_service.search
  end

  def set_factories
    @equipment_entity_factory = EquipmentEntityFactory.new
    @equipped_entity_factory = EquippedEntityFactory.new(@equipment_entity_factory)
    @equipped_list_entity_factory = EquippedListEntityFactory.new(@equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(@equipped_list_entity_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end
