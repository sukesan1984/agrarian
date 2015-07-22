class CreateUserEquipments < ActiveRecord::Migration
  def change
    create_table :user_equipments do |t|
      t.integer :player_id
      t.integer :body_region
      t.integer :user_item_id

      t.timestamps null: false
    end
  end
end
