class ItemLotteryComponentFactory
  def initialize
  end

  def build_by_group_id(group_id, root_item_lottery)
    item_lotteries = ItemLottery.where(group_id: group_id)
    if item_lotteries.count == 0
      return nil
    end
    components = []
    item_lotteries.each do |item_lottery|
      if item_lottery.has_composite_group_id
        components.push(self.build_by_group_id(item_lottery.composite_group_id, item_lottery))
      else
        components.push(Entity::ItemLottery::ItemLotteryLeafEntity.new(item_lottery))
      end
    end
    return Entity::ItemLottery::ItemLotteryCompositeEntity.new(components, root_item_lottery)
  end
end
