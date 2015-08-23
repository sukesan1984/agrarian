class AddLevelMaxToSoldiers < ActiveRecord::Migration
  def change
    add_column :soldiers, :level_max, :integer
  end
end
