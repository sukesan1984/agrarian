class Entity::SoldierCharacterEntity < Entity::CharacterEntity
  attr_reader :type, :status
  def initialize(user_soldier, equipped_list_entity)
    @type = 2
    @user_soldier = user_soldier
    @soldier = user_soldier.soldier
    @equipped_list_entity = equipped_list_entity

    @level = Level.get_level_from(user_soldier.exp)
    @level_max = Level.find_by(level: @soldier.level_max)

    @level = @level_max if @level.level > @soldier.level_max

    @vit = StatusCalculationUtility.calculate(@soldier.vit_min, @soldier.vit_max, @soldier.level_max, @level.level)
    @str = StatusCalculationUtility.calculate(@soldier.str_min, @soldier.str_max, @soldier.level_max, @level.level)
    @dex = StatusCalculationUtility.calculate(@soldier.dex_min, @soldier.dex_max, @soldier.level_max, @level.level)

    @ene = StatusCalculationUtility.calculate(@soldier.ene_min, @soldier.ene_max, @soldier.level_max, @level.level)

    critical_hit_chance = StatusCalculationUtility.calculate(@soldier.critical_hit_chance_min, @soldier.critical_hit_chance_max, @soldier.level_max, @level.level)

    critical_hit_damage = StatusCalculationUtility.calculate(@soldier.critical_hit_damage_min, @soldier.critical_hit_damage_max, @soldier.level_max, @level.level)

    dodge_chance = StatusCalculationUtility.calculate(@soldier.dodge_chance_min, @soldier.dodge_chance_max, @soldier.level_max, @level.level)

    # TODO: Soldierのデフォルトのdamage_min, damage_maxを設定する。
    @status = Status.new(1, 5, 0, 0, @str, @dex, @ene, @vit, critical_hit_chance, critical_hit_damage, dodge_chance, 0, 0, 0, 0, 0, 0) + @equipped_list_entity.status

    @hp = StatusPoint.new(@user_soldier.current_hp, @status.hp_max)
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

  def strength
    return @str
  end

  def dexterity
    return @dex
  end

  def energy
    return @ene
  end

  def vitality
    return @vit
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

