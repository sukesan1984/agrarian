class CreateEnemies < ActiveRecord::Migration
  def change
    create_table :enemies do |t|
      t.string :name
      t.integer :attack
      t.integer :defense
      t.integer :hp

      t.timestamps null: false
    end
  end
end
