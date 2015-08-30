class AddStatusColumnsToSoldiers < ActiveRecord::Migration
  def change
    add_column :soldiers, :critical_hit_chance_min, :integer, null: false, default: 0
    add_column :soldiers, :critical_hit_chance_max, :integer, null: false, default: 0

    add_column :soldiers, :critical_hit_damage_min, :integer, null: false, default: 0

    add_column :soldiers, :critical_hit_damage_max, :integer, null: false, default: 0

    add_column :soldiers, :dodge_chance_min, :integer, null: false, default: 0

    add_column :soldiers, :dodge_chance_max, :integer, null: false, default: 0

    add_column :soldiers, :damage_reduction_min, :integer, null: false, default: 0

    add_column :soldiers, :damage_reduction_max, :integer, null: false, default: 0

  end
end
