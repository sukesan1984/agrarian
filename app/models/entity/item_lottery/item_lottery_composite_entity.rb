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
      if seed < entity.weight + current
        return entity.lot
      end
      current += entity.weight
    end
  end

  def weight 
    return @item_lottery.weight
  end

  def weight_sum
    return @list.map(&:weight).inject(:+)
  end
end

