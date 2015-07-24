class AddShopIdIndexToShopProducts < ActiveRecord::Migration
  def change
    add_index :shop_products, :shop_id
  end
end
