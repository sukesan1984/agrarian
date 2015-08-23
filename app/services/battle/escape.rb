class Battle::Escape
  def initialize
  end

  def execute(player_id)
    # 逃げるのに成功したら、遭遇してる敵を削除する
    if is_success_to_escape
      UserEncounterEnemy.delete_all(player_id: player_id)
      return true
    end

    return false
  end

  private

  def is_success_to_escape
    escape_success_rate = 20
    seed = rand(1..100)
    return  escape_success_rate >= seed
  end
end

