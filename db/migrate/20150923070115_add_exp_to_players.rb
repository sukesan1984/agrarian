class AddExpToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :exp, :integer, default: 0, null: false
  end
end
