class AddActionIdToNatureFields < ActiveRecord::Migration
  def change
    add_column :nature_fields, :action_id, :integer
  end
end
