# Leaf
class Entity::ItemLottery::ItemLotteryLeafEntity
  def initialize(item_lottery)
    @item_lottery = item_lottery
    @item = ValueObjects::Item.new(item_lottery.item_id, item_lottery.count)
  end

  def lot
    return @item
  end

  def weight
    return @item_lottery.weight
  end
end

