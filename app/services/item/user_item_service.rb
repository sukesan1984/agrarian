class Item::UserItemService
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
    #先にアイテムを減らす。
    after = @user_item.count - 1
    if after < 0
      return false
    end

    @user_item.count = after

    # お金を増やす
    @player.give_rails(@user_item.item.sell_price)
  end

  # トランザクション的にはこれ使ってね
  def save!
    @user_item.save!
    @player.save!
  end
end

