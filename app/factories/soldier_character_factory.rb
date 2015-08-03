class SoldierCharacterFactory
  def initialize
  end

  def build_by_player_id(player_id)
    soldier_characters = []
    user_soldiers = UserSoldier.where(player_id: player_id)
    user_soldiers.each do |user_soldier|
      soldier_characters.push(SoldierCharacter.new(user_soldier))
    end

    return soldier_characters
  end

  def build_by_id_and_player_id(id, player_id)
    user_soldier = UserSoldier.find_by(id: id, player_id: player_id)
    return SoldierCharacter.new(user_soldier)
  end
end

