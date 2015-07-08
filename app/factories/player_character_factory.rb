# PlayerCharacterを生成する奴
class PlayerCharacterFactory
  def initialize
    @player_character_dictionary = {}
  end

  def build_by_user_id(user_id)
    if(@player_character_dictionary.has_key?(user_id))
      return @player_character_dictionary[user_id]
    end

    player = Player.find_by(user_id: user_id)
    if(player.nil?)
      return nil
    end

    @player_character_dictionary[user_id] = PlayerCharacter.new(player)
    return @player_character_dictionary[user_id]
  end
end
