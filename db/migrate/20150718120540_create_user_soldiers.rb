class CreateUserSoldiers < ActiveRecord::Migration
  def change
    create_table :user_soldiers do |t|
      t.integer :player_id
      t.integer :soldier_id
      t.integer :current_hp

      t.timestamps null: false
    end
  end
end
