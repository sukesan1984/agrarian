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

  # 受け取り済みの時だけ
  # クリア状態にする
  def set_cleared
    return change_status(Status::NotReceivedReward)
  end

  def set_received
    return change_status(Status::Received)
  end

  def set_claimed
    return change_status(Status::ReceivedReward)
  end

  # 新しいクエストを受け取れるかどうか
  def can_receive
    return status == Status::NotReceived || status == Status::ReceivedReward
  end

  def is_received
    return status == Status::Received
  end

  def is_not_received
    return status == Status::NotReceived
  end

  def is_cleared
    return status == Status::NotReceivedReward ||
      status == Status::ReceivedReward
  end

  def is_received_reward
    return status == Status::ReceivedReward
  end

  def is_not_received_reward
    return status == Status::NotReceivedReward
  end

  def status_name
    case (status)
    when 0
      return '未受注'
    when 1
      return 'クエスト進行中'
    when 2
      return '報酬未受け取り'
    when 3
      return '報酬受け取り済'
    end

    fail 'invalid status: ' + status.to_s
  end

  def name
    return quest.name
  end

  private

  # statusは0 -> 1 -> 2 -> 3 -> 1で変化する
  def change_status(status)
    current_status = self.status
    if current_status == Status::ReceivedReward
      if status == Status::Received
        self.status = status
        return true
      end
      return false
    end

    if (current_status + 1) == status
      self.status = status
      return true
    end
    return false
  end
end

