class EnemyGroupEntityFactory
  def initialize
  end

  def create_by_enemy_group_id(enemy_group_id)
    enemy_group = EnemyGroup.find_by(id: enemy_group_id) 
    enemy_instances = EnemyInstance.where(enemy_group_id: enemy_group_id)
    return Entity::EnemyGroupEntity.new(enemy_group, enemy_instances)
  end
end
