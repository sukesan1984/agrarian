class RemoveBodyRegionToUserEquipments < ActiveRecord::Migration
  def change
    remove_column :user_equipments, :body_region, :string
  end
end
