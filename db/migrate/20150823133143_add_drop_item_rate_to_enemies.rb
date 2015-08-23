class AddDropItemRateToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :drop_item_rate, :integer, null:false, default: 0
  end
end
