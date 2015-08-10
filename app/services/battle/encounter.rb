class Battle::Encounter
  def initialize(player, area, enemy_maps, enemies_lottery)
    @player = player
    @area = area
    @enemy_maps = enemy_maps
    @enemies_lottery = enemies_lottery
  end

  def encount
    ActiveRecord::Base.transaction do
      user_encounter_enemies = UserEncounterEnemy.where(player_id: @player.id)
      # すでに遭遇してる。
      if user_encounter_enemies.count > 0
        return {is_encount: true, enemies: user_encounter_enemies} 
      end

      # 敵がいない
      if @enemy_maps.count == 0
        return {is_encount: false, enemies: nil}
      end


      # 遭遇しなかった
      unless lot
        return {is_encount: false, enemies: nil}
      end


      enemy_count = rand(1..3)
      list = @enemies_lottery.lot(enemy_count)

      UserEncounterEnemy.delete_all(['player_id = ?', @player.id])
      user_encounter_enemies = []
      list.each do |enemy|
        user_encounter_enemies.push(UserEncounterEnemy.create(
          player_id: @player.id,
          enemy_id: enemy.id
        ))
      end
      return{ is_encount: true, enemies: user_encounter_enemies}
    end
    rescue => e
      raise e
  end

  # 出現するかどうかを返す
  def lot
    seed = rand(1..100)
    return true if (seed <= @area.enemy_rate)
    return false
  end
end

