class CreateUserDungeons < ActiveRecord::Migration
  def change
    create_table :user_dungeons do |t|
      t.integer :player_id, default: 0, null: false
      t.integer :dungeon_id, default: 0, null: false
      t.integer :current_floor, default: 0, null: false
      t.integer :search_count, default: 0, null: false
      t.boolean :found_footstep, default: false, null: false

      t.timestamps null: false
    end
  end
end
