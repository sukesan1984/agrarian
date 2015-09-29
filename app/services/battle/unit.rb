class Battle::Unit
  attr_accessor :done_action
  attr_reader :name, :is_dead, :status
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

  def hp
    return @battlize_character.hp
  end

  def take_damage(damage)
    @battlize_character.decrease_hp(damage)
    @is_dead = @battlize_character.hp == 0
  end

  # このユニットがターンで何をするか決める。
  def get_action(party)
    unit = party.get_attackable_unit
    return if unit.nil?

    # 対象が避けるかどうか
    if is_dodged(unit)
      return Battle::Action.new(self, unit, 'ダメージ(避けた！)', 0)
    end

    target_defense = unit.status.defense
    ave_damage = @status.attack - target_defense
    ave_damage = 0 if (ave_damage < 0)
    range = -ave_damage.fdiv(16).ceil..ave_damage.fdiv(16).ceil
    randomize = Random.rand(range)
    damage = ave_damage + randomize + 1
    damage = 1 if damage < 0 # 最低１はダメージを与える

    #critical_chance
    if has_critical_damage
      critical_damage = damage + (damage * @status.critical_hit_damage.to_f / 100.to_f).to_i
      unit.take_damage(critical_damage)
      return Battle::Action.new(self, unit, 'クリティカルダメージを与えた!!', critical_damage)
    end

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
    return UnitStatus.new(@battlize_character.hp.to_s, hp_rate.to_s, @name, @is_dead, @battlize_character.image)
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
    if(@is_dead)
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

