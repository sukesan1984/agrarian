class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.integer :recover_count
      t.integer :recover_interval
      t.integer :max_count

      t.timestamps null: false
    end
  end
end
