class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.integer :exp_min
      t.integer :exp_max
      t.integer :level

      t.timestamps null: false
    end
  end
end
