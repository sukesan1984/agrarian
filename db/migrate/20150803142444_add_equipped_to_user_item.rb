class AddEquippedToUserItem < ActiveRecord::Migration
  def change
    add_column :user_items, :equipped, :integer, default: 0
  end
end
