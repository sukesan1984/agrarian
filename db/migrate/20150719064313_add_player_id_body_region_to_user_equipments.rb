class AddPlayerIdBodyRegionToUserEquipments < ActiveRecord::Migration
  def change
    add_index :user_equipments, [:player_id, :body_region]
  end
end
