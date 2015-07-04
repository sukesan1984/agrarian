class AddIndexTownsTownId < ActiveRecord::Migration
  def change
    add_index :towns, :town_id, :unique => true
  end
end
