class Entity::PlayerCharacterEntity < Entity::CharacterEntity
  attr_reader :player, :type
  def initialize(player, equipped_list_entity)
    @player = player
    @type   = 1
    @equipped_list_entity = equipped_list_entity
    @status = Status.new(@player.str * 5, 0, 500, 50, 0, 0, 0, 0, 0, 0, 0)
    @hp = StatusPoint.new(player.hp, @player.vit * 10)
  end

  def level
    return 1
  end

  def image
    return nil
  end

  def attack
    return (@status + @equipped_list_entity.status).attack
  end

  def defense
    return (@status + @equipped_list_entity.status).defense
  end

  def strength
    return @player.str
  end

  def increase_strength(value)
    return if (@player.remaining_points < value)
    @player.str += value
    @player.remaining_points -= value
  end

  def dexterity
    return @player.dex
  end

  def increase_dexterity(value)
    return if (@player.remaining_points < value)
    @player.dex += value
    @player.remaining_points -= value
  end

  def vitality
    return @player.vit
  end

  def increase_vitality(value)
    return if (@player.remaining_points < value)
    @player.vit += value
    @player.remaining_points -= value
  end

  def energy
    return @player.ene
  end

  def increase_energy(value)
    return if (@player.remaining_points < value)
    @player.ene += value
    @player.remaining_points -= value
  end

  def remaining_points
    return @player.remaining_points
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

  def id
    @player.id
  end

  def name
    @player.name
  end

  def decrease_hp(value)
    @hp.decrease(value)
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

  def rails
    return @player.rails
  end

  def exp
    return 0
  end

  def recover_hp_all
    @hp.recover_all
  end

  def give_death_penalty
    rails_penalty_rate = 10

    reduced_rails = (rails * rails_penalty_rate / 100).to_i
    after_rails = rails - reduced_rails

    after_rails = 0 if after_rails < 0

    @player.rails = after_rails
    recover_hp_all
    return "お金が#{after_rails}になった"
  end

  def has_enough_rails?(value)
    return false unless value.is_a?(Integer)
    return @player.rails >= value
  end

  def give_rails(value)
    @player.rails += value
  end

  def give_exp(_exp)
    return {
      name: name,
      level_up: false,
      level: 1,
      exp_for_next_level: 0
    }
  end

  def decrease_rails(value)
    after_rails = @player.rails - value
    return false if after_rails < 0

    @player.rails -= value
    return true
  end

  def recover_hp(value)
    @hp += value
  end

  def drop_item
    return nil
  end

  def save!
    @player.hp = @hp.current
    @player.save!
  end
end

