class Entity::EnemyCharacterEntity
  attr_reader :status
  def initialize(enemy, progress, drop_item_entity, enemy_instance, user_enemy_history) 
    @enemy = enemy
    @enemy_instance = enemy_instance
    @user_enemy_history = user_enemy_history
    @hp = StatusPoint.new(enemy_instance.current_hp, @enemy.hp)
    @progress = progress
    @drop_item_entity = drop_item_entity
    @dropped_item_seed = rand(0...100)
    # TODO: Enemy Masterから取得する。
    @status = Status.new(@enemy.damage_min, @enemy.damage_max, 0, 0, @enemy.str, @enemy.dex, 0, 0, @enemy.critical_hit_chance, @enemy.critical_hit_damage, @enemy.dodge_chance, @enemy.damage_reduction, 0, 0, 0, 0, 0)
  end

  def name
    return @enemy.name
  end

  def image
    return 'enemies/' + @enemy.id.to_s + '.png'
  end

  def hp
    @hp.current
  end

  def hp_max
    return @hp.max
  end

  def hp_rate
    return (self.hp.to_f / self.hp_max.to_f * 100).to_i
  end

  def decrease_hp(value)
    @hp.decrease(value)
    @enemy_instance.current_hp = @hp.current
    @user_enemy_history.damage += value
    @progress.count += 1 if @hp.current <= 0
  end

  def rails
    return @enemy.rails
  end

  def exp
    return @enemy.exp
  end

  def drop_item
    return nil if @enemy.drop_item_rate <= @dropped_item_seed

    return @drop_item_entity
  end

  def save!
    @progress.save!
    @user_enemy_history.save!
    @enemy_instance.save!
  end
end

