class DamageCalculation
  MAX_CHANCE_TO_HIT     = 200
  MINIMUM_CHANCE_TO_HIT = 20
  def initialize(attacker_status, defender_status)
    @attacker_status = attacker_status
    @defender_status = defender_status
  end

  def get_damage
    final_damage = self.get_basic_damage
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

  # 基本ダメージの取得
  def get_basic_damage
    final_min_damage = self.get_final_min_damage
    final_max_damage = self.get_final_max_damage
    Rails.logger.debug("(#{final_min_damage}..#{final_max_damage})")
    return Random.rand(final_min_damage..final_max_damage)
  end

  def get_final_min_damage
    @attacker_status.damage_min * (1 + self.status_bonus + self.damage_perc_bonus).to_i
  end

  def get_final_max_damage
    @attacker_status.damage_max * (1 + self.status_bonus + self.damage_perc_bonus).to_i
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

  def status_bonus
    return @attacker_status.str.fdiv(100)
  end

  def damage_perc_bonus
    @attacker_status.damage_perc.fdiv(100)
  end
end
