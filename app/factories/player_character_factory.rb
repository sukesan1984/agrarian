# PlayerCharacterを生成する奴
class PlayerCharacterFactory
  def initialize(equipped_list_service_factory)
    @player_character_dictionary = {}
    @equipped_list_service_factory = equipped_list_service_factory
  end

  def build_by_user_id(user_id)
    if @player_character_dictionary.has_key?(user_id)
      return @player_character_dictionary[user_id]
    end

    player = Player.find_by(user_id: user_id)
    return nil unless player

    equipped_list_service = @equipped_list_service_factory.build_by_player_id(player.id)
    @player_character_dictionary[user_id] = PlayerCharacter.new(player, equipped_list_service)
    @player_character_dictionary[user_id]
  end
end
