# パーティに加えるサービス
#
class PartyAdditionService
  MAX_PARTY_NUM = 2
  def initialize()
  end

  def add(player_id, user_soldier_id)
    # 今仲間になっている数
    if UserSoldier.where(player_id: player_id, is_in_party: 1).count >= MAX_PARTY_NUM
      return false
    end

    target = UserSoldier.find_by(id: user_soldier_id, player_id: player_id, is_in_party: 0)

    if target.nil?
      return false
    end

    ActiveRecord::Base.transaction do
      target.is_in_party = 1
      target.save!
      return true
    end 
    rescue => e
      raise e
  end
end
