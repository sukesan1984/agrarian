class AddExpToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :exp, :integer
  end
end
