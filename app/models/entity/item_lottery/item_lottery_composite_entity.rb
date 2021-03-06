class Entity::ItemLottery::ItemLotteryCompositeEntity
  def initialize(list, item_lottery)
    @list = list
    @item_lottery = item_lottery
  end

  def lot
    weight_sum = self.weight_sum
    seed = rand(0...weight_sum)
    current = 0
    @list.each do |entity|
      return entity.lot if seed < entity.weight + current
      current += entity.weight
    end
  end

  def weight
    return @item_lottery.weight
  end

  def weight_sum
    Rails.logger.debug(@list)
    return @list.map(&:weight).inject(:+)
  end
end

