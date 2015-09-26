# PlayerCharacterを生成する奴
class PlayerCharacterFactory
  def initialize(equipped_list_entity_factory)
    @player_character_dictionary = {}
    @player_character_dictionary_for_player_id = {}
    @equipped_list_entity_factory = equipped_list_entity_factory
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

  def build_by_player_ids(player_ids)
    Rails.logger.debug("build_by_player_ids")
    player_characters = []
    not_cached_player_ids = []
    player_ids.each do |player_id|
      if @player_character_dictionary_for_player_id.key?(player_id)
        player_characters.push(build_by_player(@player_character_dictionary_for_player_id[player_id]))
      else
        not_cached_player_ids.push(player_id)
      end
    end

    players = Player.where('id in (?)', not_cached_player_ids)
    player_characters = player_characters.concat(build_by_players(players))

    return player_characters
  end

  private
  def build_by_player(player)
    equipped_list_entity = @equipped_list_entity_factory.build_by_player_id(player.id)
    player_character = Entity::PlayerCharacterEntity.new(player, equipped_list_entity)
    @player_character_dictionary[player.user_id] = player_character
    @player_character_dictionary_for_player_id[player.id] = player_character
    return player_character
  end

  def build_by_players(players)
    player_characters = []
    players.each do |player|
      player_characters.push(build_by_player(player))
    end
    return player_characters
  end
end

