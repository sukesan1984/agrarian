# ダンジョンに入場させるサービス
class Dungeon::DungeonEntranceService
  def initialize(user_dungeon, dungeon)
    @user_dungeon = user_dungeon
    @dungeon = dungeon
  end

  # ダンジョンに入場する
  def enter
    ActiveRecord::Base.transaction do
      if @user_dungeon.dungeon_id > 0
        fail 'already entering dungeon'
      end

      @user_dungeon.setup_to_dungeon_entrance(@dungeon.id)
      @user_dungeon.save!
    end
  rescue => e
    raise e
  end
end

