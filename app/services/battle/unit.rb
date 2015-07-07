class Battle::Unit
  attr_accessor :done_action
  attr_reader :name, :hp, :is_dead, :defense, :attack
  # battlize.name
  # battlize.attack
  # battlize.defense
  # battlize.hp
  def initialize(battlize)
    @name     = battlize.name
    @attack   = battlize.attack
    @defense  = battlize.defense
    @hp       = battlize.hp
    @is_dead = false
    @done_action = false
  end

  def take_damage(damage)
    @hp -= damage
    if(@hp <= 0)
      @hp = 0
      @is_dead = true
    end
  end

  # このユニットがターンで何をするか決める。
  def get_action(party)
    unit = party.get_attackable_unit
    target_defense = unit.defense
    ave_damage = (@attack / 2.0 - target_defense / 4.0).ceil
    range = -(ave_damage / 16.0).ceil..(ave_damage/16.0).ceil
    randomize = Random.rand(range)
    damage = ave_damage + randomize + 1
    unit.take_damage(damage)
    return Battle::Action.new(self, unit, "ダメージを与えた", damage)
  end

  def get_current_state
    state = @name + "の現在HP: " + @hp.to_s()
    if(@is_dead)
      state += " [死亡]"
    end

    return state
  end
end