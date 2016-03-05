# ダンジョンを先に進むサービス
class Dungeon::DungeonAscendingService
  def initialize(dungeon_entity)
    @dungeon_entity = dungeon_entity
  end

  def ascend
    ActiveRecord::Base.transaction do
      @dungeon_entity.ascend
      @dungeon_entity.save!
    end
  rescue => e
    raise e
  end
end
