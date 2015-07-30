# == Schema Information
#
# Table name: shop_products
#
#  id         :integer          not null, primary key
#  shop_id    :integer
#  item_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_shop_products_on_shop_id  (shop_id)
#

FactoryGirl.define do
  factory :shop_product do
    shop_id 1
    item_id 1
    count 1
  end
end

