# == Schema Information
#
# Table name: user_areas
#
#  player_id    :integer          default(0), not null, primary key
#  area_node_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :user_area do
  end
end

