class RenameAttackColumnToEquipment < ActiveRecord::Migration
  def change
    add_column :equipment, :damage_min, :integer, default:0, null: false
    rename_column :equipment, :attack, :damage_max
  end
end
