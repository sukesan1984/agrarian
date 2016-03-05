# ダンジョン一つ一つを扱うエンティティ
class Entity::DungeonEntity
  def initialize(dungeon, user_dungeon)
    @dungeon = dungeon
    @user_dungeon = user_dungeon
  end

  # ダンジョンに入場する
  def enter
    if @user_dungeon.dungeon_id > 0
      fail 'already entering dungeon'
    end

    @user_dungeon.setup_to_dungeon_entrance(@dungeon.id)
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

  def save!
    @user_dungeon.save!
  end
end
