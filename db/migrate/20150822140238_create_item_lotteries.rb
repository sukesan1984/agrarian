class CreateItemLotteries < ActiveRecord::Migration
  def change
    create_table :item_lotteries do |t|
      t.integer :group_id
      t.integer :item_id
      t.integer :count
      t.integer :weight
      t.integer :composite_group_id

      t.timestamps null: false
    end
  end
end
