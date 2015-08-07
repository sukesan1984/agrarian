class AddExpToUserSoldiers < ActiveRecord::Migration
  def change
    add_column :user_soldiers, :exp, :integer, default: 0
  end
end
