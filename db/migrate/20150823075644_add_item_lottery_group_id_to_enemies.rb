class AddItemLotteryGroupIdToEnemies < ActiveRecord::Migration
  def change
    add_column :enemies, :item_lottery_group_id, :integer, null:false, default:0
  end
end
