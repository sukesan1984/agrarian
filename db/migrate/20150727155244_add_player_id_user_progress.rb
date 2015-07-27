class AddPlayerIdUserProgress < ActiveRecord::Migration
  def change
    add_column :user_progresses, :player_id, :integer
  end
end
