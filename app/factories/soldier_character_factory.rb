class SoldierCharacterFactory
  def initialize(equipped_list_service_factory)
    @equipped_list_service_factory = equipped_list_service_factory
  end

  def build_by_player_id(player_id)
    soldier_characters = []
    user_soldiers = UserSoldier.where(player_id: player_id)
    user_soldiers.each do |user_soldier|
      soldier_characters.push(build_by_user_soldier(user_soldier, player_id))
    end

    return soldier_characters
  end

  def build_by_id_and_player_id(id, player_id)
    user_soldier = UserSoldier.find_by(id: id, player_id: player_id)
    return build_by_user_soldier(user_soldier, player_id)
  end

  private
  def build_by_user_soldier(user_soldier, player_id)
    equipped_list_service = @equipped_list_service_factory.build_by_character_type_and_character_id_and_player_id(2, user_soldier.id, player_id) 
    return SoldierCharacter.new(user_soldier, equipped_list_service)
  end
end

