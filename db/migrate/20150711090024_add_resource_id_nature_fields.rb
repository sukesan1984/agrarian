class AddResourceIdNatureFields < ActiveRecord::Migration
  def change
    add_column :nature_fields, :resource_id, :integer
  end
end
