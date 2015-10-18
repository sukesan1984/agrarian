class AddAffixesToUserEquipmentAffixes < ActiveRecord::Migration
  def change
    add_column :user_equipment_affixes, :str, :integer, default: 0, null: false
    add_column :user_equipment_affixes, :dex, :integer, default: 0, null: false
    add_column :user_equipment_affixes, :vit, :integer, default: 0, null: false
    add_column :user_equipment_affixes, :ene, :integer, default: 0, null: false
  end
end
