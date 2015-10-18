class AddAffixesToEquipmentAffixes < ActiveRecord::Migration
  def change
    add_column :equipment_affixes, :str_min, :integer, default: 0, null: false
    add_column :equipment_affixes, :str_max, :integer, default: 0, null: false
    add_column :equipment_affixes, :dex_min, :integer, default: 0, null: false
    add_column :equipment_affixes, :dex_max, :integer, default: 0, null: false
    add_column :equipment_affixes, :vit_min, :integer, default: 0, null: false
    add_column :equipment_affixes, :vit_max, :integer, default: 0, null: false
    add_column :equipment_affixes, :ene_min, :integer, default: 0, null: false
    add_column :equipment_affixes, :ene_max, :integer, default: 0, null: false
  end
end
