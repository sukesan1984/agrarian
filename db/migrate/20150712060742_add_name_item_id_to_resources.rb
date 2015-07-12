class AddNameItemIdToResources < ActiveRecord::Migration
  def change
    add_column :resources, :name, :string
    add_column :resources, :item_id, :integer
  end
end
