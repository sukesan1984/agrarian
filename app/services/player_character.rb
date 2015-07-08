class PlayerCharacter
  attr_reader :name, :attack, :defense
  def initialize(player)
    @player = player
    @name = player.name
    @attack = 5
    @defense  = 3
    @hp = StatusPoint.new(player.hp, player.hp_max)
  end

  def decrease_hp(value)
    @hp.decrease(value)
  end

  def hp
    return @hp.current
  end

  def recover_hp_all
    @hp.recover_all
  end

  def save
    @player.hp = @hp.current
    @player.save
  end
end
