class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :name
      t.string :description
      t.integer :reward_gift_id

      t.timestamps null: false
    end
  end
end
