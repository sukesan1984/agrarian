class PlayerCharacter
  attr_reader :name, :attack, :defense, :hp
  def initialize(player)
    @name = player.name
    @attack = 5
    @defense  = 3
    @hp     = 50
  end
end
