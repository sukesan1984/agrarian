class PlayerCharacter
  attr_reader :player, :type
  def initialize(player, equipped_list_service)
    @player = player
    @type   = 1
    @equipped_list_service = equipped_list_service
    @status = Status.new(5, 3)
    @hp = StatusPoint.new(player.hp, player.hp_max)
  end

  def attack
    Rails.logger.debug((@status + @equipped_list_service.status).attack)
    return (@status + @equipped_list_service.status).attack
  end

  def defense
    Rails.logger.debug((@status + @equipped_list_service.status).defense)
    return (@status + @equipped_list_service.status).defense
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

  def rails
    return @player.rails
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

  def decrease_rails(value)
    after_rails = @player.rails - value
    if after_rails < 0
      return false
    end

    @player.rails -= value
    return true
  end

  def recover_hp(value)
    @hp += value
  end

  def save
    @player.hp = @hp.current
    @player.save
  end

  def save!
    @player.hp = @hp.current
    @player.save!
  end
end

