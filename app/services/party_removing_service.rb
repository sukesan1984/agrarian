class PartyRemovingService
  def initialize
  end

  def remove(player_id, user_soldier_id)
    target = UserSoldier.find_by(id: user_soldier_id, player_id: player_id, is_in_party: 1)
    if target.nil?
      return false
    end
    ActiveRecord::Base.transaction do
      target.is_in_party = 0
      target.save!
      return true
    end
    rescue => e 
      raise e
  end
end
