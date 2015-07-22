class AddItemIdIndexToConsumptions < ActiveRecord::Migration
  def change
    add_index :consumptions, :item_id, unique: true
  end
end
