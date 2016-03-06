class Entity::UserEncounterEnemyGroupEntity
  # 自分のレコード: user_encounter_enemy_group
  # 自分含めて他人のレコード（複数) : user_encounter_enemy_groups
  # グループに紐づくenemy: enemy_instances
  # 紐づくenemy_groupのinstance
  def initialize(user_encounter_enemy_group, user_encounter_enemy_groups, enemy_instances, enemy_group)
    @user_encounter_enemy_group = user_encounter_enemy_group
    @user_encounter_enemy_groups = user_encounter_enemy_groups
    @enemy_instances = enemy_instances
    @enemy_group = enemy_group

    @will_be_destroied_objects = []
  end

  # 未遭遇状態にする
  def make_unencountered
    # 自分以外は遭遇していない時
    if @user_encounter_enemy_groups.count == 1
      @will_be_destroied_objects.push(@enemy_group)
      @will_be_destroied_objects.push(@enemy_instances)
      @will_be_destroied_objects.flatten!
    end
    @user_encounter_enemy_group.enemy_group_id = 0
  end

  def save!
    @user_encounter_enemy_group.save!
    @will_be_destroied_objects.each(&:destroy)
  end
end
