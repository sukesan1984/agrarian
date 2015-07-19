# == Schema Information
#
# Table name: equipment
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  body_region :integer
#  attack      :integer
#  defense     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :equipment do
    item_id 1
body_region 1
attack 1
defense 1
  end

end
