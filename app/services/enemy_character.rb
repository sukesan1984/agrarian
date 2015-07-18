class EnemyCharacter
  def initialize(enemy)
    @enemy = enemy
    @hp = StatusPoint.new(@enemy.hp, @enemy.hp)
  end

  def name
    return @enemy.name
  end

  def attack
    return @enemy.attack
  end

  def defense
    return @enemy.defense
  end

  def hp
    @hp.current
  end

  def hp_max
    return @hp.max
  end

  def decrease_hp(value)
    @hp.decrease(value)
  end

  def rails
    return @enemy.rails
  end

  def save
    #何もしない
  end
end
