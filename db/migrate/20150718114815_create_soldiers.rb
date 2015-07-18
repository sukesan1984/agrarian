class CreateSoldiers < ActiveRecord::Migration
  def change
    create_table :soldiers do |t|
      t.string :name
      t.string :description
      t.integer :attack
      t.integer :defense
      t.integer :hp

      t.timestamps null: false
    end
  end
end
