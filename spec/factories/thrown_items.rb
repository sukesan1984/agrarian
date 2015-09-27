# == Schema Information
#
# Table name: thrown_items
#
#  id           :integer          not null, primary key
#  area_node_id :integer
#  item_id      :integer
#  count        :integer
#  thrown_at    :datetime         default(NULL)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  lock_version :integer          default(0), not null
#
# Indexes
#
#  index_thrown_items_on_area_node_id_and_item_id  (area_node_id,item_id) UNIQUE
#

FactoryGirl.define do
  factory :thrown_item do
    area_node_id 1
    item_id 1
    count 1
    thrown_at '2015-08-01 13:10:55'
  end
end

