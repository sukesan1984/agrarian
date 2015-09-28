class RenameAttackDefenseColumnToEnemies < ActiveRecord::Migration
  def change
    rename_column :enemies, :attack,  :str
    rename_column :enemies, :defense, :defense_rating
  end
end
