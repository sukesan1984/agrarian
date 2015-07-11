class AddTargetIdIndexToResourceKeepers < ActiveRecord::Migration
  def change
    add_index :resource_keepers, :target_id, unique: true
  end
end
