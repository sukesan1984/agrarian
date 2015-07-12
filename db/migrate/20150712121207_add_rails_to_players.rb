class AddRailsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :rails, :integer, default: 300
  end
end
