class AddAreaIdIndexToEnemyMaps < ActiveRecord::Migration
  def change
    add_index :enemy_maps, :area_id
  end
end
