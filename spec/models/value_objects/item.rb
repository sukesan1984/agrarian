require 'rails_helper'
RSpec.describe Entity::ItemLottery::ItemLotteryLeafEntity do
  it 'lot' do
    item_lottery = ItemLottery.new(
      group_id: 1,
      item_id: 1,
      count: 1
    )
    leaf = Entity::ItemLottery::ItemLotteryLeafEntity.new(item_lottery)
    expect(leaf.lot.item_id).to eq 1
    expect(leaf.lot.count).to eq 1
  end
end

