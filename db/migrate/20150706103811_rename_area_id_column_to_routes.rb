class RenameAreaIdColumnToRoutes < ActiveRecord::Migration
  def change
    rename_column :routes, :area_id, :area_node_id
    rename_column :routes, :connected_area_id, :connected_area_node_id
  end
end
