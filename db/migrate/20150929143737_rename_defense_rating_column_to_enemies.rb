class RenameDefenseRatingColumnToEnemies < ActiveRecord::Migration
  def change
    rename_column :enemies, :defense_rating, :defense
  end
end
