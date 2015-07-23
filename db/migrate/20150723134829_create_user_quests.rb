class CreateUserQuests < ActiveRecord::Migration
  def change
    create_table :user_quests do |t|
      t.integer :player_id
      t.integer :quest_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
