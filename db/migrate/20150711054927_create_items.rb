class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :item_type
      t.integer :item_type_id

      t.timestamps null: false
    end
  end
end
