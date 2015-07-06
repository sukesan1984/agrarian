class CreateAreaNodes < ActiveRecord::Migration
  def change
    create_table :area_nodes do |t|
      t.integer :area_id
      t.integer :node_point

      t.timestamps null: false
    end
  end
end
