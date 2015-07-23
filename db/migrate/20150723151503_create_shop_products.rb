class CreateShopProducts < ActiveRecord::Migration
  def change
    create_table :shop_products do |t|
      t.integer :shop_id
      t.integer :item_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
