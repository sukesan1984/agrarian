class UserEncounterEnemyGroupEntityFactory
  def initialize
    # 必要あれば、外から渡してもいいよ。
    @enemy_group_entity_factory = EnemyGroupEntityFactory.new
  end

  def create_by_player_id(player_id)
    user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: player_id)
    user_encounter_enemy_groups = UserEncounterEnemyGroup.where(enemy_group_id: user_encounter_enemy_group.enemy_group_id)

    enemy_group_entity = @enemy_group_entity_factory.create_by_enemy_group_id(user_encounter_enemy_group.enemy_group_id)


    return Entity::UserEncounterEnemyGroupEntity.new(user_encounter_enemy_group, user_encounter_enemy_groups, enemy_group_entity)
  end
end
