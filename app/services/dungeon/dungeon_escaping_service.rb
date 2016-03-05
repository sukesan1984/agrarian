# ダンジョンを脱出するサービス
class Dungeon::DungeonEscapingService
  def initialize(dungeon_entity)
    @dungeon_entity = dungeon_entity
  end

  def escape
    ActiveRecord::Base.transaction do
      @dungeon_entity.escape
      @dungeon_entity.save!
    end
  rescue => e
    raise e
  end
end
