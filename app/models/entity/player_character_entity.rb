class Entity::PlayerCharacterEntity
  attr_reader :player, :type
  def initialize(player, equipped_list_service)
    @player = player
    @type   = 1
    @equipped_list_service = equipped_list_service
    @status = Status.new(5, 3, 5, 50, 0, 0)
    @hp = StatusPoint.new(player.hp, player.hp_max)
  end

  def level
    return 1
  end

  def image
    return nil
  end

  def attack
    return (@status + @equipped_list_service.status).attack
  end

  def defense
    return (@status + @equipped_list_service.status).defense
  end

  def critical_hit_chance
    return (@status + @equipped_list_service.status).critical_hit_chance
  end

  def critical_hit_damage
    return (@status + @equipped_list_service.status).critical_hit_damage
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

