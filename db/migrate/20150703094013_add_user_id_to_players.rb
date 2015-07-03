class AddUserIdToPlayers < ActiveRecord::Migration
  def change
    add_index :players, :user_id, unique:true
  end
end
