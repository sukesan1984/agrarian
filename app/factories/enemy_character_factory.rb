class EnemyCharacterFactory
  def initialize
    @progress_cache = Hash.new
  end

  # enemyから生成する
  def  build_by_enemy(player_id, enemy)
    if @progress_cache.has_key?(enemy.id)
      user_progress = @progress_cache[enemy.id]
    else
      user_progress = UserProgress.get_or_create(player_id, ProgressType::KillEnemy, enemy.id)
      # cache
      @progress_cache[enemy.id] = user_progress
    end

    return EnemyCharacter.new(enemy, user_progress)
  end
end
