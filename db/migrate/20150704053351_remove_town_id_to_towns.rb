class RemoveTownIdToTowns < ActiveRecord::Migration
  def change
    remove_column :towns, :town_id, :string
  end
end
