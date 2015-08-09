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

require 'rails_helper'

RSpec.describe UserQuest, type: :model do
  it 'status change' do
    user_quest = UserQuest.new(
      player_id: 1,
      quest_id: 1,
      status: 0
    )

    # クエスト未受け取り状態から
    expect(user_quest.set_cleared).to eq false
    expect(user_quest.is_not_received).to eq true
    expect(user_quest.set_claimed).to eq false
    expect(user_quest.is_not_received).to eq true

    expect(user_quest.set_received).to eq true
    expect(user_quest.is_received).to eq true

    # クエスト受け取り状態から
    expect(user_quest.set_claimed).to eq false
    expect(user_quest.is_received).to eq true
    expect(user_quest.set_uncleared).to eq false
    expect(user_quest.is_received).to eq true

    expect(user_quest.set_cleared).to eq true
    expect(user_quest.is_not_received_reward).to eq true

    # クエストクリア状態から
    expect(user_quest.set_uncleared).to eq false
    expect(user_quest.is_not_received_reward).to eq true
    expect(user_quest.set_received).to eq false
    expect(user_quest.is_not_received_reward).to eq true

    expect(user_quest.set_claimed).to eq true
    expect(user_quest.is_received_reward).to eq true

  end
end

