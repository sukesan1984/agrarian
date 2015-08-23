class CreateThrownItems < ActiveRecord::Migration
  def change
    create_table :thrown_items do |t|
      t.integer :area_node_id
      t.integer :item_id
      t.integer :count
      t.time :thrown_at

      t.timestamps null: false
    end
  end
end
