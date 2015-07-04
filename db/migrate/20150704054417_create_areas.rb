class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :type
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
