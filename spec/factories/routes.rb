# == Schema Information
#
# Table name: routes
#
#  id                     :integer          not null, primary key
#  area_node_id           :integer
#  connected_area_node_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_routes_on_area_node_id  (area_node_id)
#

FactoryGirl.define do
  factory :route do
  end
end

