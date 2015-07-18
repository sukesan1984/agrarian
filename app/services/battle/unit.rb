class Battle::Unit
  attr_accessor :done_action
  attr_reader :name, :is_dead, :defense, :attack
  # battlize_character.name
  # battlize_character.attack
  # battlize_character.defense
  # battlize_character.hp
  def initialize(battlize_character)
    @battlize_character = battlize_character
    @name     = battlize_character.name
    @attack   = battlize_character.attack
    @defense  = battlize_character.defense
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
    if(unit.nil?)
      return
    end
    target_defense = unit.defense
    ave_damage = (@attack / 2.0 - target_defense / 4.0).ceil
    range = -(ave_damage / 16.0).ceil..(ave_damage/16.0).ceil
    randomize = Random.rand(range)
    damage = ave_damage + randomize + 1
    unit.take_damage(damage)
    return Battle::Action.new(self, unit, "ダメージを与えた", damage)
  end

  def get_current_state
    hp_rate = (@battlize_character.hp.to_f / @battlize_character.hp_max.to_f * 100).to_i
    return UnitStatus.new(@battlize_character.hp.to_s, hp_rate.to_s, @name, @is_dead)
  end

  # 状態を永続化する
  def save
    @battlize_character.save
  end

  def rails
    return @battlize_character.rails
  end
end

class Battle::Unit::UnitStatus
  attr_reader :hp, :name, :is_dead, :hp_rate
  def initialize(hp, hp_rate, name, is_dead)
    @hp      = hp
    @hp_rate = hp_rate
    @name    = name
    @is_dead = is_dead
  end
end
