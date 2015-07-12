class CreateShowcases < ActiveRecord::Migration
  def change
    create_table :showcases do |t|
      t.integer :shop_id
      t.integer :resource_id
      t.integer :cost

      t.timestamps null: false
    end
  end
end
