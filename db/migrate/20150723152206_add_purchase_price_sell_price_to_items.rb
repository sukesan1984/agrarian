class AddPurchasePriceSellPriceToItems < ActiveRecord::Migration
  def change
    add_column :items, :purchase_price, :integer
    add_column :items, :sell_price, :integer
  end
end
