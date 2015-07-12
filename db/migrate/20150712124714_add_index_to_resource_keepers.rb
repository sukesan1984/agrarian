class AddIndexToResourceKeepers < ActiveRecord::Migration
  def change
    add_index :resource_keepers, [:target_id, :resource_id], :unique => true
  end
end
