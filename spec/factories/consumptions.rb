# == Schema Information
#
# Table name: consumptions
#
#  id               :integer          not null, primary key
#  item_id          :integer
#  consumption_type :integer
#  type_value       :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_consumptions_on_item_id  (item_id) UNIQUE
#

FactoryGirl.define do
  factory :consumption do
    item_id 1
consumption_type 1
type_value 1
  end

end
