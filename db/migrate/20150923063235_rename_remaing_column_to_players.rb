class RenameRemaingColumnToPlayers < ActiveRecord::Migration
  def change
    rename_column :players, :remaing_points, :remaining_points
  end
end
