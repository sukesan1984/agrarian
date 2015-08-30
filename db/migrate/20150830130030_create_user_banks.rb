class CreateUserBanks < ActiveRecord::Migration
  def change
    create_table :user_banks do |t|
      t.integer :player_id
      t.integer :rails, null: false, default: 0

      t.timestamps null: false
    end

    add_index :user_banks, :player_id, unique: true
  end
end
