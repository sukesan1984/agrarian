class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.integer :area_id
      t.integer :connected_area_id

      t.timestamps null: false
    end
  end
end
