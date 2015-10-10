class DamageCalculation
  MAX_CHANCE_TO_HIT     = 200
  MINIMUM_CHANCE_TO_HIT = 20
  def initialize(attacker_status, defender_status)
    @attacker_status = attacker_status
    @defender_status = defender_status
  end

  def get_damage
    final_damage = @attacker_status.get_basic_damage
    if critical?
      final_damage *= (1 + @attacker_status.critical_hit_damage.fdiv(100))
    end
    final_damage -= @defender_status.damage_reduction
    return final_damage
  end

  # 攻撃が当たるかどうか
  def dodge?
    dodge_seed = Random.rand(0...100)
    return dodge_seed < self.get_chance_to_hit
  end

  # クリティカルが発動するかどうか
  def critical?
    return Random.rand(0..10000) < @attacker_status.critical_hit_chance
  end

  def get_chance_to_hit
    chance_to_hit = MAX_CHANCE_TO_HIT * (@attacker_status.attack.fdiv((@attacker_status.attack + @defender_status.defense)))
    if (chance_to_hit <= MINIMUM_CHANCE_TO_HIT)
      return MINIMUM_CHANCE_TO_HIT
    end
    if (chance_to_hit > 100)
      chance_to_hit = 100
    end

    return chance_to_hit - @defender_status.dodge_chance
  end
end
