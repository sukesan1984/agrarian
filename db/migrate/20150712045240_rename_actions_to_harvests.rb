class RenameActionsToHarvests < ActiveRecord::Migration
  def change
    rename_table :actions, :harvests
  end
end
