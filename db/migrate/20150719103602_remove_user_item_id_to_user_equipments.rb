class RemoveUserItemIdToUserEquipments < ActiveRecord::Migration
  def change
    remove_column :user_equipments, :user_item_id, :string
  end
end
