class ItemLottery < ActiveRecord::Migration
  def change
    change_column_null :item_lotteries, :composite_group_id, false
  end
end
