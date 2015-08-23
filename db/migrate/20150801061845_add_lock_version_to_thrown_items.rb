class AddLockVersionToThrownItems < ActiveRecord::Migration
  def change
    add_column :thrown_items, :lock_version, :integer, default: 0, null: false
  end
end
