class AddStatusColumnsToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :critical_hit_chance, :integer, null: false, default: 0 
    add_column :enemies, :critical_hit_damage, :integer, null: false, default: 0
    add_column :enemies, :dodge_chance, :integer, null: false, default: 0
    add_column :enemies, :damage_reduction, :integer, null: false, default: 0
  end
end
