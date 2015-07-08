class PlayerCharacterTest < ActiveSupport::TestCase
  test "hp decrease" do
    player_character = PlayerCharacter.new(PlayerMock.new)
    player_character.decrease_hp(100)
    assert(player_character.hp == 0)
  end
end

class PlayerMock
  attr_reader :name, :hp, :hp_max
  def initialize()
    @name   = "sukesan1984"
    @hp     = 50
    @hp_max = 50
  end
end
