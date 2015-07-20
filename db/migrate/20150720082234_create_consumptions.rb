class CreateConsumptions < ActiveRecord::Migration
  def change
    create_table :consumptions do |t|
      t.integer :item_id
      t.integer :consumption_type
      t.integer :type_value

      t.timestamps null: false
    end
  end
end
