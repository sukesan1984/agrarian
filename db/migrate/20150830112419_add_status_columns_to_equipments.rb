class AddStatusColumnsToEquipments < ActiveRecord::Migration
  def change
    add_column :equipment, :critical_hit_chance, :integer, null: false, default: 0
    add_column :equipment, :critical_hit_damage, :integer, null: false, default: 0

    add_column :equipment, :dodge_chance, :integer, null: false, default: 0

    add_column :equipment, :damage_reduction, :integer, null: false, default: 0

  end
end
