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
end

