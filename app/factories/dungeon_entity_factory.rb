class DungeonEntityFactory
  def initialize
  end

  def create_by_player_id_and_dungeon_id(player_id, dungeon_id)
    dungeon = Dungeon.find_by(id: dungeon_id)
    if dungeon.nil?
      fail "dungeon is not found: #{dungeon_id}"
    end

    user_dungeon = UserDungeon.find_or_new(player_id)
    dungeon_entity = Entity::DungeonEntity.new(dungeon, user_dungeon)
    return dungeon_entity
  end

  def create_by_player_id(player_id)
    user_dungeon = UserDungeon.find_by(player_id: player_id)
    if user_dungeon.nil? or user_dungeon.dungeon_id == 0
      fail "user is not entering dungeon"
    end

    dungeon = Dungeon.find_by(id: user_dungeon.dungeon_id)
    if dungeon.nil?
      fail "dungeon is not found: #{user_dungeon.dungeon_id}"
    end

    dungeon_entity = Entity::DungeonEntity.new(dungeon, user_dungeon)
    return dungeon_entity
  end
end
