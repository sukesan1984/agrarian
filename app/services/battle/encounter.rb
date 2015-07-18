class Battle::Encounter
  def initialize(area, enemies_lottery)
    @area = area
    @enemies_lottery = enemies_lottery
  end

  def encount
    # 遭遇しなかった
    if(!self.lot)
      return nil
    end

    enemy_count = rand(1..3)

    return @enemies_lottery.lot(enemy_count)
  end

  # 出現するかどうかを返す
  def lot
    seed = rand(1..100)
    if(seed <= @area.enemy_rate)
      return true
    end
    return false
  end
end
