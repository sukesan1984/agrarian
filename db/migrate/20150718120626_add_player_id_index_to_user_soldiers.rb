class AddPlayerIdIndexToUserSoldiers < ActiveRecord::Migration
  def change
    add_index :user_soldiers, :player_id
  end
end
