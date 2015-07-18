class SoldierCharacter
  def initialize(soldier)
    @soldier  = soldier
    @hp = StatusPoint.new(@soldier.hp, @soldier.hp)
  end

  def name
    return @soldier.name
  end

  def attack
    return @soldier.attack
  end

  def defense
    return @soldier.defense
  end

  def hp
    return @hp.current
  end

  def hp_max
    return @hp.max
  end

  def decrease_hp(value)
    @hp.decrease(value)
  end
  
  def save
  end
end
