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

class ShopProduct < ActiveRecord::Base
end

