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
      # 装備してるやつは売られへん
      return { success: false, message: 'それ装備してるで' } if @user_item.equipped == 1
      # 先にアイテムを減らす。
      after = @user_item.count - 1
      return { success: false, message: '持っておまへん' } if after < 0

      @user_item.count = after

      # お金を増やす
      @player.give_rails(@user_item.item.sell_price)
      @player.save!
      @user_item.save!
      return { success: false, message: "#{name}が#{sell_price}railsで売れて#{@player.rails}railsになった。今#{@user_item.count}個持ってるわ" }
    end
    rescue => e
      raise e
  end
end

