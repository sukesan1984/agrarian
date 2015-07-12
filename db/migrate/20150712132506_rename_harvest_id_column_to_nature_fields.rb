class RenameHarvestIdColumnToNatureFields < ActiveRecord::Migration
  def change
    rename_column :nature_fields, :harvest_id, :resource_action_id
  end
end
