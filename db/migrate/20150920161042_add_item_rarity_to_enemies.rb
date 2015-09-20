class AddItemRarityToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :item_rarity, :integer
  end
end
