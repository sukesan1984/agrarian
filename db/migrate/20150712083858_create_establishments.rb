class CreateEstablishments < ActiveRecord::Migration
  def change
    create_table :establishments do |t|
      t.integer :town_id
      t.integer :establishment_type
      t.integer :establishment_id

      t.timestamps null: false
    end
  end
end
