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
#  right_hand :integer          default(0)
#  left_hand  :integer          default(0)
#  both_hand  :integer          default(0)
#  body       :integer          default(0)
#  head       :integer          default(0)
#  leg        :integer          default(0)
#  neck       :integer          default(0)
#  belt       :integer          default(0)
#  amulet     :integer          default(0)
#  ring_a     :integer          default(0)
#  ring_b     :integer          default(0)
#
# Indexes
#
#  index_user_soldiers_on_player_id  (player_id)
#

FactoryGirl.define do
  factory :user_soldier do
  end
end

