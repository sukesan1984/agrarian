class Entity::SoldierCharacterEntity < Entity::CharacterEntity
  attr_reader :type
  def initialize(user_soldier, equipped_list_entity)
    @type = 2
    @user_soldier = user_soldier
    @soldier = user_soldier.soldier
    @equipped_list_entity = equipped_list_entity

    @level = Level.get_level_from(user_soldier.exp)
    @level_max = Level.find_by(level: @soldier.level_max)

    @level = @level_max if @level.level > @soldier.level_max

    @hp = StatusPoint.new(@user_soldier.current_hp, @soldier.hp_min)
    attack = StatusCalculationUtility.calculate(@soldier.attack_min, @soldier.attack_max, @soldier.level_max, @level.level)
    defense = StatusCalculationUtility.calculate(@soldier.defense_min, @soldier.defense_max, @soldier.level_max, @level.level)

    critical_hit_chance = StatusCalculationUtility.calculate(@soldier.critical_hit_chance_min, @soldier.critical_hit_chance_max, @soldier.level_max, @level.level)

    critical_hit_damage = StatusCalculationUtility.calculate(@soldier.critical_hit_damage_min, @soldier.critical_hit_damage_max, @soldier.level_max, @level.level)

    dodge_chance = StatusCalculationUtility.calculate(@soldier.dodge_chance_min, @soldier.dodge_chance_max, @soldier.level_max, @level.level)

    @status = Status.new(attack, defense, critical_hit_chance, critical_hit_damage, dodge_chance, 0, 0, 0, 0, 0, 0)
  end

  def id
    return @user_soldier.id
  end

  def image
    return nil
  end

  def name
    return @soldier.name
  end

  def level
    return @level.level
  end

  def attack
    return (@status + @equipped_list_entity.status).attack
  end

  def defense
    return (@status + @equipped_list_entity.status).defense
  end

  def critical_hit_chance
    return (@status + @equipped_list_entity.status).critical_hit_chance
  end 

  def critical_hit_damage
    return (@status + @equipped_list_entity.status).critical_hit_damage
  end

  def dodge_chance
    return (@status + @equipped_list_entity.status).dodge_chance
  end

  def hp
    return @hp.current
  end

  def hp_max
    return @hp.max
  end

  def hp_rate
    return (self.hp.to_f / self.hp_max.to_f * 100).to_i
  end

  def decrease_hp(value)
    @hp.decrease(value)
  end

  def recover_hp_all
    @hp.recover_all
  end

  def rails
    return 0
  end

  def exp
    return @user_soldier.exp
  end

  def is_in_party
    return @user_soldier.is_in_party == 1
  end

  def give_exp(exp)
    after_exp = @user_soldier.exp + exp
    after_exp = @level_max.exp_max if after_exp > @level_max.exp_max

    @user_soldier.exp = after_exp
    @after_level = Level.get_level_from(@user_soldier.exp)
    is_max_level = @after_level.level == @soldier.level_max
    is_level_up = @after_level.level > @level.level
    @level = is_level_up ? @after_level : @level

    return {
      name: name,
      level_up: is_level_up,
      level: @level.level,
      exp_for_next_level: is_max_level ? 0 : @level.exp_for_next_level(@user_soldier.exp)
    }
  end

  def recover_hp(value)
    @hp += value
  end

  def drop_item
    return nil
  end

  def save!
    @user_soldier.current_hp = @hp.current
    @user_soldier.save!
  end
end

