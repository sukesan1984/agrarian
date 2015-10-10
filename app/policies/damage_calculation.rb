class DamageCalculation
  MAX_CHANCE_TO_HIT     = 200
  MINIMUM_CHANCE_TO_HIT = 20
  def initialize(attacker_status, defender_status)
    @attacker_status = attacker_status
    @defender_status = defender_status
  end

  # 攻撃が当たるかどうか
  def dodge?()
    dodge_seed = Random.rand(0...100)
    return dodge_seed < self.get_chance_to_hit
  end

  def get_final_min_damage
  end

  def get_final_max_damage
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
