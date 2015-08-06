class AddLevelIndexToLevels < ActiveRecord::Migration
  def change
    add_index :levels, :level
  end
end
