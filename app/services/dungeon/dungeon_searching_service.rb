# ダンジョンを探索させるサービス
class Dungeon::DungeonSearchingService
  def initialize(dungeon_entity)
    @dungeon_entity = dungeon_entity
  end

  # ダンジョンを探索する
  def search
    ActiveRecord::Base.transaction do
      @dungeon_entity.countup_search_rate
      @dungeon_entity.find_foot_step
      @dungeon_entity.save!
    end
  rescue => e
    raise e
  end
end

