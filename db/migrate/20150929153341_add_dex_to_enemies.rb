class AddDexToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :dex, :integer
  end
end
