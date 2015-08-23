class AddAttackMaxDefenseMaxHpMax < ActiveRecord::Migration
  def change
    add_column :soldiers, :attack_max, :integer
    add_column :soldiers, :defense_max, :integer
    add_column :soldiers, :hp_max, :integer
  end
end
