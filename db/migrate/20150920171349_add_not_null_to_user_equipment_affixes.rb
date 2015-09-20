class AddNotNullToUserEquipmentAffixes < ActiveRecord::Migration
  def change
    change_column_null :user_equipment_affixes, :user_item_id, false
    change_column_null :user_equipment_affixes, :equipment_affix_id, false
  end
end
