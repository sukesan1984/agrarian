class Battle::Escape
  def initialize
  end

  def execute(player_id)
    # 逃げるのに成功したら、遭遇してる敵を削除する
    if is_success_to_escape
      user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: player_character.id)
      # 
      if UserEncounterEnemyGroup.where(enemy_group_id: user_encouter_enemy_group.enemy_group_id).count == 0
        EnemyGroup.delete_all(id: user_encounter_enemy_group.enemy_group_id)
        enemy_instances = EnemyInstance.where(enemy_group_id: user_encounter_enemy_group.enemy_group_id)
        enemy_instances.each(&:destroy)
      end
      user_encounter_enemy_group.enemy_group_id = 0
      user_encounter_enemy_group.save!
      return true
    end

    return false
  end

  private

  def is_success_to_escape
    escape_success_rate = 20
    seed = rand(1..100)
    return escape_success_rate >= seed
  end
end

