class AddAreaIdIndexToRoutes < ActiveRecord::Migration
  def change
    add_index :routes, :area_id
  end
end
