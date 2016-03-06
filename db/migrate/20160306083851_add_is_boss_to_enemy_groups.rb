class AddIsBossToEnemyGroups < ActiveRecord::Migration
  def change
    add_column :enemy_groups, :is_boss, :boolean, null: false, default: 0
  end
end
