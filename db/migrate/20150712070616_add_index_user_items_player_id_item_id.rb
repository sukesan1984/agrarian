class AddIndexUserItemsPlayerIdItemId < ActiveRecord::Migration
  def change
    add_index :user_items, [:player_id, :item_id]
  end
end
