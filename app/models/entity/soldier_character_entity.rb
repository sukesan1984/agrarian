class Entity::SoldierCharacterEntity
  attr_reader :type
  def initialize(user_soldier, equipped_list_service)
    @type = 2
    @user_soldier = user_soldier
    @soldier  = user_soldier.soldier
    @equipped_list_service = equipped_list_service

    @level = Level.get_level_from(user_soldier.exp)
    @level_max = Level.find_by(level:  @soldier.level_max)

    @level = @level_max if @level.level > @soldier.level_max

    @hp = StatusPoint.new(@user_soldier.current_hp, @soldier.hp_min)
    attack = StatusCalculationUtility.calculate(@soldier.attack_min, @soldier.attack_max, @soldier.level_max, @level.level)
    defense = StatusCalculationUtility.calculate(@soldier.defense_min, @soldier.defense_max, @soldier.level_max, @level.level)
    @status = Status.new(attack, defense)
  end

  def id
    return @user_soldier.id
  end

  def name
    return @soldier.name
  end

  def level
    return @level.level
  end

  def attack
    return (@status + @equipped_list_service.status).attack
  end

  def defense
    return (@status + @equipped_list_service.status).defense
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

  def save!
    @user_soldier.current_hp = @hp.current
    if (@hp.current <= 0)
      @equipped_list_service.unequip_all
      @equipped_list_service.save!
      @user_soldier.destroy
    else
      @user_soldier.save!
    end
  end
end

