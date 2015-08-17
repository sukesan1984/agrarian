class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :required_item_id1
      t.integer :required_item_num1
      t.integer :required_item_id2
      t.integer :required_item_num2
      t.integer :required_item_id3
      t.integer :required_item_num3
      t.integer :required_item_id4
      t.integer :required_item_num4
      t.integer :required_item_id5
      t.integer :required_item_num5
      t.integer :product_item_id
      t.integer :product_item_num

      t.timestamps null: false
    end
  end
end
