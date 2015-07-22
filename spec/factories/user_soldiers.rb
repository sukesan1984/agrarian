# == Schema Information
#
# Table name: user_soldiers
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  soldier_id :integer
#  current_hp :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_soldiers_on_player_id  (player_id)
#

FactoryGirl.define do
  factory :user_soldier do
  end
end

