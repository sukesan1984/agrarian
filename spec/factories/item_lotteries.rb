# == Schema Information
#
# Table name: item_lotteries
#
#  id                 :integer          not null, primary key
#  group_id           :integer
#  item_id            :integer
#  count              :integer
#  weight             :integer
#  composite_group_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :item_lottery do
    group_id 1
item_id 1
count 1
weight 1
composite_group_id 1
  end

end
