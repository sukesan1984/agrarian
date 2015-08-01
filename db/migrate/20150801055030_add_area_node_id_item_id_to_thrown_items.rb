class AddAreaNodeIdItemIdToThrownItems < ActiveRecord::Migration
  def change
    add_index :thrown_items, [:area_node_id, :item_id], unique: true
  end
end
