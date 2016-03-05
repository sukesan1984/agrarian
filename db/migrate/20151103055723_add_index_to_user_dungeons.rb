class AddIndexToUserDungeons < ActiveRecord::Migration
  def change
    add_index :user_dungeons, :player_id, unique: true 
  end
end
