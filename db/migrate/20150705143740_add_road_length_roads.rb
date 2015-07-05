class AddRoadLengthRoads < ActiveRecord::Migration
  def change
    add_column :roads, :road_length, :integer
  end
end
