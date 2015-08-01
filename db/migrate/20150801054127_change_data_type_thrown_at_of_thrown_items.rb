class ChangeDataTypeThrownAtOfThrownItems < ActiveRecord::Migration
  def up
    change_column :thrown_items, :thrown_at, :datetime, default: 0
  end
  def down
    change_column :thrown_items, :thrown_at, :time, default: 0
  end
end
