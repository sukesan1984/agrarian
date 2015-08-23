class Entity::EnemyCharacterEntity
  def initialize(enemy, progress, drop_item_entity) 
    @enemy = enemy
    @hp = StatusPoint.new(@enemy.hp, @enemy.hp)
    @progress = progress
    @drop_item_entity = drop_item_entity
    @dropped_item_seed = rand(0...100)
  end

  def name
    return @enemy.name
  end

  def image
    return 'enemies/' + @enemy.id.to_s + '.png'
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
    @progress.count += 1 if @hp.current <= 0
  end

  def rails
    return @enemy.rails
  end

  def exp
    return @enemy.exp
  end

  def drop_item
    if @enemy.drop_item_rate <= @dropped_item_seed
      return nil
    end

    return @drop_item_entity
  end

  def save!
    @progress.save!
  end
end

