class RenameActionIdToNatureFields < ActiveRecord::Migration
  def change
    rename_column :nature_fields, :action_id, :harvest_id
  end
end
