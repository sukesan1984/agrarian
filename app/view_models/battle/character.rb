class Battle::Character
  attr_accessor :done_action
  attr_reader :name, :hp, :is_dead
  def initialize(name, atk, hp)
    @name = name
    @atk  = atk
    @hp   = hp
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

  def get_action(party)
    unit = party.get_attackable_unit
    unit.take_damage(@atk)
    return Battle::Action.new(self, unit, "ダメージを与えた", @atk);
  end
end
