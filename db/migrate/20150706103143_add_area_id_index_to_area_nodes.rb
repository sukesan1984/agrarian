class AddAreaIdIndexToAreaNodes < ActiveRecord::Migration
  def change
    add_index :area_nodes, :area_id
  end
end
