require 'rails_helper'
RSpec.describe Entity::ItemLottery::ItemLotteryCompositeEntity do
  it 'weight_sum' do
    list = []
    list.push(Entity::ItemLottery::ItemLotteryLeafEntity.new(ItemLottery.new(weight:1)))
    list.push(Entity::ItemLottery::ItemLotteryLeafEntity.new(ItemLottery.new(weight:10)))
    list.push(Entity::ItemLottery::ItemLotteryLeafEntity.new(ItemLottery.new(weight:6)))

    composite = Entity::ItemLottery::ItemLotteryCompositeEntity.new(list, ItemLottery.new(weight: 1))
    expect(composite.weight_sum).to eq 17
  end
end

