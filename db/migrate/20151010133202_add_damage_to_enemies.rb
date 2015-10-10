class AddDamageToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :damage_min, :integer, default: 0, null: false
    add_column :enemies, :damage_max, :integer, default: 0, null: false
  end
end
