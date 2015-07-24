# == Schema Information
#
# Table name: gifts
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :gift do
    item_id 1
count 1
  end

end
