# == Schema Information
#
# Table name: thrown_items
#
#  id           :integer          not null, primary key
#  area_node_id :integer
#  item_id      :integer
#  count        :integer
#  thrown_at    :datetime         default(NULL), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :thrown_item do
    area_node_id 1
item_id 1
count 1
thrown_at "2015-08-01 13:10:55"
  end

end
