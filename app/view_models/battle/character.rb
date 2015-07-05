class Battle::Character
  def initialize(name, atk, hp)
    @name = name
    @atk  = atk
    @hp   = hp
    @is_dead = false
  end

  def get_name()
    return @name
  end

  def take_damage(damage)
    @hp -= damage
    if(@hp < 0)
      @hp = 0
      @is_dead = true
    end
  end

  # いずれはパーティをとるようにするが、一旦party = characterで
  def get_action(party)
    party.take_damage(@atk)
    return Battle::Action.new(self, party, "ダメージを与えた", @atk);
  end
end
