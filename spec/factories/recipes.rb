# == Schema Information
#
# Table name: recipes
#
#  id                   :integer          not null, primary key
#  required_item_id1    :integer
#  required_item_count1 :integer
#  required_item_id2    :integer
#  required_item_count2 :integer
#  required_item_id3    :integer
#  required_item_count3 :integer
#  required_item_id4    :integer
#  required_item_count4 :integer
#  required_item_id5    :integer
#  required_item_count5 :integer
#  product_item_id      :integer
#  product_item_count   :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

FactoryGirl.define do
  factory :recipe do
    required_item_id1 1
required_item_num1 1
required_item_id2 1
required_item_num2 1
required_item_id3 1
required_item_num3 1
required_item_id4 1
required_item_num4 1
required_item_id5 1
required_item_num5 1
product_item_id 1
product_item_num 1
  end

end
