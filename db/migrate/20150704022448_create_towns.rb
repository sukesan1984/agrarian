class CreateTowns < ActiveRecord::Migration
  def change
    create_table :towns do |t|
      t.integer :town_id
      t.string :name

      t.timestamps null: false
    end
  end
end
