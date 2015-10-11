class AddUserItemIdToThrownItems < ActiveRecord::Migration
  def change
    add_column :thrown_items, :user_item_id, :integer, default: 0, null: false
  end
end
