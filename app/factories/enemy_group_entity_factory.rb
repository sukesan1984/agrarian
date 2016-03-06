class EnemyGroupEntityFactory
  def initialize
  end

  def create_by_player_id(player_id)
    user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: player_id)
    user_encounter_enemy_groups = UserEncounterEnemyGroup.where(enemy_group_id: user_encounter_enemy_group.enemy_group_id)
    enemy_group = EnemyGroup.find_by(id: user_encounter_enemy_group.enemy_group_id)
    enemy_instances = EnemyInstance.where(enemy_group_id: user_encounter_enemy_group.enemy_group_id)

    return Entity::UserEncounterEnemyGroupEntity.new(user_encounter_enemy_group, user_encounter_enemy_groups, enemy_instances, enemy_group)
  end
end
