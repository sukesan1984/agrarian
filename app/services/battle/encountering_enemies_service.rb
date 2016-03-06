class Battle::EncounteringEnemiesService
  def initialize(player, area_node, user_encounter_enemy_group, enemy_maps, enemies_lottery)
    @player = player
    @area_node = area_node
    @user_encounter_enemy_group = user_encounter_enemy_group
    @enemy_maps = enemy_maps
    @enemies_lottery = enemies_lottery
  end

  def encount
    ActiveRecord::Base.transaction do
      # すでに遭遇してる。
      current = self.get_current_encounter
      if current[:is_encount]
        return current
      end

      # 敵がいない
      return { is_encount: false, enemies: nil } if @enemy_maps.count == 0

      # 遭遇しなかった
      return { is_encount: false, enemies: nil } unless lot

      return { is_encount: false, enemies: nil } if @area_node.area.enemy_num <= 0

      enemy_count = rand(1..@area_node.area.enemy_num)
      list = @enemies_lottery.lot(enemy_count)

      enemy_group = EnemyGroup.create(
        area_node_id: @area_node.id, 
        status: EnemyGroup::Status::Alive,
        player_num: 1)

      enemy_instances = []
      list.each do |enemy|
        enemy_instances.push EnemyInstance.create(
          enemy_group_id: enemy_group.id,
          enemy_id: enemy.id,
          current_hp: enemy.hp)
      end

      @user_encounter_enemy_group.enemy_group_id = enemy_group.id
      @user_encounter_enemy_group.save!

      return{ is_encount: true, enemies: enemy_instances }
    end
  rescue => e
    raise e
  end

  def get_current_encounter
    if @user_encounter_enemy_group.enemy_group_id != 0 
      enemy_instances = EnemyInstanceFactory::get_by_enemy_group_id(@user_encounter_enemy_group.enemy_group_id)
      return { is_encount: true, enemies: enemy_instances }
    end
    return { is_encount: false, enemies: nil }
  end

  # 出現するかどうかを返す
  def lot
    seed = rand(1..100)
    return true if (seed <= @area_node.area.enemy_rate)
    return false
  end
end

