class AddResourceIdToResourceKeepers < ActiveRecord::Migration
  def change
    add_column :resource_keepers, :resource_id, :integer, default: 1
  end
end
