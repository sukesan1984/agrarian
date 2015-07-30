class CreateInns < ActiveRecord::Migration
  def change
    create_table :inns do |t|
      t.string :name
      t.string :description
      t.integer :rails

      t.timestamps null: false
    end
  end
end
