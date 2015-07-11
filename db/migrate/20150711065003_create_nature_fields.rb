class CreateNatureFields < ActiveRecord::Migration
  def change
    create_table :nature_fields do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
