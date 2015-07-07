class AddHpToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :hp, :integer, :default => 50
    add_column :players, :hp_max, :integer, :default => 50
  end
end
