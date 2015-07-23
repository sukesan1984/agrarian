# == Schema Information
#
# Table name: user_quests
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  quest_id   :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_quests_on_player_id_and_quest_id  (player_id,quest_id) UNIQUE
#

class UserQuest < ActiveRecord::Base
  belongs_to :quest

  def self.find_or_create(player_id, quest_id)
    user_quest = UserQuest.find_by(player_id: player_id, quest_id: quest_id)
    if user_quest.nil?
      user_quest = UserQuest.create(
        player_id: player_id,
        quest_id: quest_id,
        status: 0
      )
    end
    return user_quest
  end

  module Status
    NotReceived = 0
    Received = 1
    NotReceivedReward = 2
    ReceivedReward = 3
  end

  # 新しい報酬を受け取れるかどうか
  def can_receive
    return self.status == 0 || self.status == 3
  end

  def set_status_to_received 
    change_status(Status::Received)
  end

  private 
  def change_status(status)
    self.status = status
  end
end
