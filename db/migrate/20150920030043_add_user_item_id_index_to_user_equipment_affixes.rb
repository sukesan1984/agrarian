class AddUserItemIdIndexToUserEquipmentAffixes < ActiveRecord::Migration
  def change
    add_index :user_equipment_affixes, :user_item_id
  end
end
