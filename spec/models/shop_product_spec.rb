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

require 'rails_helper'

RSpec.describe ShopProduct, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

