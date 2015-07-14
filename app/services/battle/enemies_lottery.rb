# 戦う敵を抽選するクラス
class Battle::EnemiesLottery
  def initialize(enemy_maps)
    @enemy_maps = enemy_maps
    @total = @enemy_maps.inject(0) {|sum, hash| sum + hash[:weight]}
  end

  # count数だけ抽選する
  def lot(count)
    list = Array.new

    count.times do
      enemy = self.lot_enemy()
      Rails.logger.debug(enemy)
      list.push(enemy)
    end

    return list
  end

  def lot_enemy
    target = rand(1..@total)
    passed = 0
    @enemy_maps.each do |enemy_map|
      if(enemy_map.weight + passed >= target)
        return enemy_map.enemy
      end
      passed += enemy_map.weight
    end
  end
end
