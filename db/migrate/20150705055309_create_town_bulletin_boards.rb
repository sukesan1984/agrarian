class CreateTownBulletinBoards < ActiveRecord::Migration
  def change
    create_table :town_bulletin_boards do |t|
      t.integer :town_id
      t.integer :player_id
      t.string :contents

      t.timestamps null: false
    end
  end
end
