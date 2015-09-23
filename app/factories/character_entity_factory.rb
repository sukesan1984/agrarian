class CharacterEntityFactory
  def initialize(player_character_factory, soldier_character_factory)
    @player_character_factory = player_character_factory
    @soldier_character_factory = soldier_character_factory
  end

  def build_by_character_type_and_character_id_and_player_id(character_type, character_id, player_id)
    case (character_type.to_i)
    when 1
      return @player_character_factory.build_by_player_id(player_id)
    when 2
      return @soldier_character_factory.build_by_id_and_player_id(character_id, player_id)
    end
  end
end

