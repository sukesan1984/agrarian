# == Schema Information
#
# Table name: user_equipments
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  right_hand :integer
#  left_hand  :integer
#  both_hand  :integer
#  body       :integer
#  head       :integer
#  leg        :integer
#  neck       :integer
#  belt       :integer
#  amulet     :integer
#  ring_a     :integer
#  ring_b     :integer
#
# Indexes
#
#  index_user_equipments_on_player_id_and_body_region  (player_id)
#

FactoryGirl.define do
  factory :user_equipment do
    player_id 1
    body_region 1
    user_item_id 1
  end
end

