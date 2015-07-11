class CreateUserItems < ActiveRecord::Migration
  def change
    create_table :user_items do |t|
      t.integer :player_id
      t.integer :item_id
      t.integer :count

      t.timestamps null: false
    end
  end
end
