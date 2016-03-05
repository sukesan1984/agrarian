# ダンジョンを探索させるサービス
class Dungeon::DungeonSearchingService
  def initialize(user_dungeon, dungeon)
    @user_dungeon = user_dungeon
    @dungeon = dungeon
  end

  # ダンジョンを探索する
  def search
    ActiveRecord::Base.transaction do
      self.countup_search_rate
      self.find_foot_step
      @user_dungeon.save!
    end
  rescue => e
    raise e
  end

  # 探索率を上昇させる
  def countup_search_rate
    search_rate = self.get_search_rate
    if @user_dungeon.search_count + search_rate > 100
      @user_dungeon.search_count = 100
      return
    end

    @user_dungeon.search_count += search_rate
  end

  # 階段を捜索する
  # みつけるかどうかは別
  def find_foot_step
    # すでに階段を見つけているときは何もしない
    if @user_dungeon.found_footstep
      return
    end

    if @user_dungeon.search_count > Random.new.rand(0..100)
      @user_dungeon.found_footstep = true
    end
  end

  # どれくらい探索出来るかを取得する
  def get_search_rate
    random = Random.new

    search_rate = random.rand(@dungeon.min_search...@dungeon.max_search)

    return search_rate
  end
end

