class AddTownIdToTownBulletinBoards < ActiveRecord::Migration
  def change
    add_index :town_bulletin_boards, :town_id
  end
end
