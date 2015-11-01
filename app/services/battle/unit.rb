class Battle::Unit
  attr_accessor :done_action
  attr_reader :name, :status
  # battlize_character.name
  # battlize_character.attack
  # battlize_character.defense
  # battlize_character.hp
  def initialize(battlize_character)
    @battlize_character = battlize_character
    @name     = battlize_character.name
    @status = battlize_character.status
    @is_dead = false
    @done_action = false
  end

  def is_dead
    @is_dead = @battlize_character.hp <= 0
    return @is_dead
  end

  def hp
    return @battlize_character.hp
  end

  def take_damage(damage)
    @battlize_character.decrease_hp(damage)
  end

  # このユニットがターンで何をするか決める。
  def get_action(party)
    unit = party.get_attackable_unit
    return if unit.nil?

    damage_calculation = DamageCalculation.new(@status, unit.status)

    # 対象が避けるかどうか
    if damage_calculation.dodge?
      return Battle::Action.new(self, unit, 'ダメージ(避けた！)', 0)
    end

    damage = damage_calculation.get_damage
    if damage <= 0 
      damage = 1
    end

    recovery = damage_calculation.get_recovery(damage)

    if(recovery > 0)
      unit.take_damage(damage - recovery)
      message =  "ダメージを与えて、%dHPを吸い取った" % [recovery]
      return Battle::Action.new(self, unit, message, damage)
    end
    #Rails.logger.debug("Damage: {damage}")

    unit.take_damage(damage)
    return Battle::Action.new(self, unit, 'ダメージを与えた', damage)
  end

  def has_critical_damage
    randomize = Random.rand(0...10000)
    # クリティカル発動せず。
    Rails.logger.debug("randomize: #{randomize} / #{@status.critical_hit_chance}")
    if randomize > @status.critical_hit_chance
      return false
    end
    return true
  end

  def is_dodged(target)
    randomize = Random.rand(0...10000)

    Rails.logger.debug("dodge : #{randomize} / #{@status.dodge_chance}")
    if randomize > target.status.dodge_chance
      return false
    end
    return true
  end

  def get_current_state
    hp_rate = @battlize_character.hp_rate 
    return UnitStatus.new(@battlize_character.hp.to_s, hp_rate.to_s, @name, is_dead, @battlize_character.image)
  end

  # 状態を永続化する
  def save!
    @battlize_character.save!
  end

  def rails
    return @battlize_character.rails
  end

  def exp
    return @battlize_character.exp
  end

  def give_exp(exp)
    if(is_dead)
      return false
    end
    return @battlize_character.give_exp(exp)
  end

  def drop_item
    return @battlize_character.drop_item
  end
end

class Battle::Unit::UnitStatus
  attr_reader :hp, :name, :is_dead, :hp_rate, :image
  def initialize(hp, hp_rate, name, is_dead, image)
    @hp      = hp
    @hp_rate = hp_rate
    @name    = name
    @is_dead = is_dead
    @image = image
  end
end

