class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.integer :item_id
      t.integer :body_region
      t.integer :attack
      t.integer :defense

      t.timestamps null: false
    end
  end
end
