class Item::ItemSaleService
  def initialize(player, user_item)
    @player = player
    @user_item = user_item
  end

  def name
    return @user_item.item.name
  end

  def count
    return @user_item.count
  end

  def sell_price
    return @user_item.item.sell_price
  end

  # このアイテム売る
  def sell
    ActiveRecord::Base.transaction do
      # 先にアイテムを減らす。
      after = @user_item.count - 1
      return false if after < 0

      @user_item.count = after

      # お金を増やす
      @player.give_rails(@user_item.item.sell_price)
      @player.save!
      @user_item.save!
    end
    rescue => e
      raise e
  end
end

