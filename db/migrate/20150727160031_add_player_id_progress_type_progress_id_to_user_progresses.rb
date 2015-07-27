class AddPlayerIdProgressTypeProgressIdToUserProgresses < ActiveRecord::Migration
  def change
    add_index :user_progresses, [:player_id, :progress_type, :progress_id], unique: true, :name => 'index1'
  end
end
