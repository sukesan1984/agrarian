class RemoveTargetIdIndexToResourceKeepers < ActiveRecord::Migration
  def change
    remove_index :resource_keepers, :target_id
  end
end
