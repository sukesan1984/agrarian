# == Schema Information
#
# Table name: user_equipments
#
#  id           :integer          not null, primary key
#  player_id    :integer
#  body_region  :integer
#  user_item_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_user_equipments_on_player_id_and_body_region  (player_id,body_region)
#

FactoryGirl.define do
  factory :user_equipment do
    player_id 1
body_region 1
user_item_id 1
  end

end
