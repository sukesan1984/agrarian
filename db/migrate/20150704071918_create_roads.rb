class CreateRoads < ActiveRecord::Migration
  def change
    create_table :roads do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
