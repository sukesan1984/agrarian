class AddRailsToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :rails, :integer
  end
end
