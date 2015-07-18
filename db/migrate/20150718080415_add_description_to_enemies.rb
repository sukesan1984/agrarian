class AddDescriptionToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :description, :string
  end
end
