class CreateItemAbilityLists < ActiveRecord::Migration
  def change
    create_table :item_ability_lists do |t|
      t.integer :item_id
      t.integer :item_ability_id

      t.timestamps null: false
    end
  end
end
