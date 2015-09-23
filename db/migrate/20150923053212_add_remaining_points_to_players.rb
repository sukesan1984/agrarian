class AddRemainingPointsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :remaing_points, :integer, default: 0, null:false
  end
end
