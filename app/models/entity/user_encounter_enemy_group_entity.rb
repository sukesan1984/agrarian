class Entity::UserEncounterEnemyGroupEntity
  # 自分のレコード: user_encounter_enemy_group
  # 自分含めて他人のレコード（複数) : user_encounter_enemy_groups
  # enemy_group_entity
  def initialize(user_encounter_enemy_group, user_encounter_enemy_groups, enemy_group_entity)
    @user_encounter_enemy_group = user_encounter_enemy_group
    @user_encounter_enemy_groups = user_encounter_enemy_groups
    @enemy_group_entity = enemy_group_entity
  end

  # 未遭遇状態にする
  def make_unencountered
    # 自分以外は遭遇していない時
    if @user_encounter_enemy_groups.count == 1
      @enemy_group_entity.destroy
    end
    @user_encounter_enemy_group.enemy_group_id = 0
  end

  def save!
    @user_encounter_enemy_group.save!
    @enemy_group_entity.save!
  end
end
