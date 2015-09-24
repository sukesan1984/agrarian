class AddLevelToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :level, :integer, default: 0, null:false
  end
end
