class CreateEnemyMaps < ActiveRecord::Migration
  def change
    create_table :enemy_maps do |t|
      t.integer :area_id
      t.integer :enemy_id
      t.integer :weight

      t.timestamps null: false
    end
  end
end
