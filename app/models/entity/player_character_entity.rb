class Entity::PlayerCharacterEntity < Entity::CharacterEntity
  attr_reader :player, :type, :status
  PLAYER_MAX_LEVEL = 30
  ADD_REMAINING_POINTS_WHEN_LEVELUP = 5
  def initialize(player, equipped_list_entity)
    @player = player
    @type   = 1
    @equipped_list_entity = equipped_list_entity
    # TODO: プレイヤーデフォルトのdamange_min, damage_maxを設定する
    @status = Status.new(1, 5, @player.str * 5, @player.dex * 5, 500, 50, 0, 0, 0, 0, 0, 0, 0) + @equipped_list_entity.status
    @hp = StatusPoint.new(player.hp, @player.vit * 10)

    @level = Level.get_level_from(player.exp)
    @level_max = Level.find_by(level: PLAYER_MAX_LEVEL) 
    @level = @level_max if @level.level > PLAYER_MAX_LEVEL
  end

  def level
    return @level.level
  end

  def image
    return nil
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

  def give_exp(exp)
    after_exp = @player.exp + exp
    after_exp = @level_max.exp_max if after_exp > @level_max.exp_max
    @player.exp = after_exp
    @after_level = Level.get_level_from(@player.exp)
    is_max_level = @after_level == PLAYER_MAX_LEVEL
    is_level_up = @after_level.level > @level.level
    @level = is_level_up ? @after_level : @level

    # レベルアップしたら
    if is_level_up
      @player.remaining_points += ADD_REMAINING_POINTS_WHEN_LEVELUP
      self.recover_hp_all
    end

    return {
      name: name,
      level_up: is_level_up,
      level: @level.level,
      exp_for_next_level: is_max_level ? 0 : @level.exp_for_next_level(@player.exp)
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

  def reset_status_points
    points = (self.level - 1) * ADD_REMAINING_POINTS_WHEN_LEVELUP
    @player.str = 2
    @player.dex = 5
    @player.vit = 3
    @player.ene = 5
    @player.remaining_points = points
  end

  def save!
    @player.hp = @hp.current
    @player.save!
  end
end

