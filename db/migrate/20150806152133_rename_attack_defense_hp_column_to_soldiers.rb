class RenameAttackDefenseHpColumnToSoldiers < ActiveRecord::Migration
  def change
    rename_column :soldiers, :attack, :attack_min
    rename_column :soldiers, :defense, :defense_min
    rename_column :soldiers, :hp, :hp_min
  end
end
