class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.integer :item_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
