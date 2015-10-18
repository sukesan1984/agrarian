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
  def sell(item_count)
    ActiveRecord::Base.transaction do
      item_count = 1 if item_count <= 0 
      # 装備してるやつは売られへん
      return { success: false, message: 'それ装備してるで' } if @user_item.equipped == 1
      # 先にアイテムを減らす。
      after = @user_item.count - item_count
      return { success: false, message: '持っておまへん' } if after < 0

      @user_item.count = after

      # お金を増やす
      @player.give_rails(@user_item.item.sell_price * item_count)
      @player.save!
      @user_item.save!
      return { success: false, message: "#{name}#{item_count}個が#{sell_price * item_count}railsで売れて#{@player.rails}railsになった。今#{@user_item.count}個持ってるわ" }
    end
  rescue => e
    raise e
  end
end

