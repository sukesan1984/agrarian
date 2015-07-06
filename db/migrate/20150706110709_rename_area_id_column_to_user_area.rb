class RenameAreaIdColumnToUserArea < ActiveRecord::Migration
  def change
    rename_column :user_areas, :area_id, :area_node_id
  end
end
