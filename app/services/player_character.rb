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

  def recover_hp_all
    @hp.recover_all
  end

  def save
    @player.hp = @hp.current
    @player.save
  end
end
