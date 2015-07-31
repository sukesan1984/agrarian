# PlayerCharacterを生成する奴
class PlayerCharacterFactory
  def initialize(equipped_list_service_factory)
    @player_character_dictionary = {}
    @player_character_dictionary_for_player_id = {}
    @equipped_list_service_factory = equipped_list_service_factory
  end

  def build_by_user_id(user_id)
    if @player_character_dictionary.key?(user_id)
      return @player_character_dictionary[user_id]
    end

    player = Player.find_by(user_id: user_id)
    return nil unless player

    return build_by_player(player)
  end

  def build_by_player_id(player_id)
    if @player_character_dictionary_for_player_id.key?(player_id)
      return @player_character_dictionary_for_player_id[player_id]
    end

    player = Player.find_by(id: player_id)
    return nil unless player

    return build_by_player(player)
  end

  private 
  def build_by_player(player)
    equipped_list_service = @equipped_list_service_factory.build_by_player_id(player.id)
    player_character = PlayerCharacter.new(player, equipped_list_service)
    @player_character_dictionary[player.user_id] = player_character
    @player_character_dictionary_for_player_id[player.id] = player_character
    return player_character
  end
end

