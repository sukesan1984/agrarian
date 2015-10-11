class RemoveIndexToThrownItems < ActiveRecord::Migration
  def change
    remove_index :thrown_items, [:area_node_id, :item_id]
    add_index :thrown_items, [:area_node_id, :item_id, :user_item_id], unique: true
  end
end
