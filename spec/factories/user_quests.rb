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

FactoryGirl.define do
  factory :user_quest do
    player_id 1
quest_id 1
status 1
  end

end
