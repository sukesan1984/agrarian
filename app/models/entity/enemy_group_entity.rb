# EnemyGroupのEntity
class Entity::EnemyGroupEntity
  def initialize(enemy_group, enemy_instances)
    @enemy_group = enemy_group
    @enemy_instances = enemy_instances

    @will_be_destroied_objects = []
  end

  # enemy_groupとそれに紐づくenemy_instancesをdestroyする
  def destroy
    @will_be_destroied_objects.push(@enemy_group)
    @will_be_destroied_objects.push(@enemy_instances)
    @will_be_destroied_objects.flatten!
  end

  def save!
    @will_be_destroied_objects.each(&:destroy)
  end

end

