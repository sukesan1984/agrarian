class EnemyInstanceFactory
  def initialize
  end

  # すでに存在しているはずのenemy_instancesを取得する。
  def self.get_by_enemy_group_id(enemy_group_id)
    enemy_group = EnemyGroup.find_by(id: enemy_group_id)
    fail "enemy group is not found: #{enemy_group_id}" unless enemy_group
    enemy_instances = EnemyInstance.where(enemy_group_id: enemy_group.id)
    fail "enemy_instances are not found :#{enemy_group.id}" if enemy_instances.count == 0

    return enemy_instances
  end
end
