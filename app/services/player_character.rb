class PlayerCharacter
  attr_reader :attack, :defense, :player
  def initialize(player)
    @player = player
    @attack = 5
    @defense  = 3
    @hp = StatusPoint.new(player.hp, player.hp_max)
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

    reduced_rails = (self.rails * rails_penalty_rate / 100).to_i
    after_rails = self.rails - reduced_rails

    if(after_rails < 0)
      after_rails = 0
    end

    @player.rails = after_rails
    self.recover_hp_all
    return "お金が#{after_rails}になった"
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
