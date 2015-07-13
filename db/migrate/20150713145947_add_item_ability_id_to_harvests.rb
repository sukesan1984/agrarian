class AddItemAbilityIdToHarvests < ActiveRecord::Migration
  def change
    add_column :harvests, :item_ability_id, :integer
  end
end
