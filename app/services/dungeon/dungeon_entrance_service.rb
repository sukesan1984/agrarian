# ダンジョンに入場させるサービス
class Dungeon::DungeonEntranceService
  def initialize(dungeon_entity)
    @dungeon_entity = dungeon_entity
  end

  # ダンジョンに入場する
  def enter
    ActiveRecord::Base.transaction do
      @dungeon_entity.enter
      @dungeon_entity.save!
    end
  rescue => e
    raise e
  end
end

