class AddMaxPlayerNumToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :max_player_num, :integer, null: false, default: 1
  end
end
