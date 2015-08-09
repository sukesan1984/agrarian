class Battle::Encounter
  def initialize(player, area, enemy_maps, enemies_lottery)
    @player = player
    @area = area
    @enemy_maps = enemy_maps
    @enemies_lottery = enemies_lottery
  end

  def encount
    ActiveRecord::Base.transaction do
      # 敵がいない
      return if @enemy_maps.count == 0

      # 遭遇しなかった
      return unless lot

      enemy_count = rand(1..3)
      list = @enemies_lottery.lot(enemy_count)

      UserEncounterEnemy.delete_all(['player_id = ?', @player.id])
      list.each do |enemy|
        UserEncounterEnemy.create(
          player_id: @player.id,
          enemy_id: enemy.id
        )
      end
      return true
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

