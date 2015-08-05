class ItemServiceFactory
  def initialize(player, user_item_factory)
    @player = player
    @user_item_factory = user_item_factory
  end

  def build_by_item_id(item_id, count)
    user_item = @user_item_factory.build_by_player_id_and_item_id(@player.id, item_id)
    case user_item.item.item_type
    when 1, 2, 4
      return Item::ConsumeItem.new(user_item, count)
    when 3
      return Item::SoldierItem.new(@player, user_item)
    when 5
      return Item::QuestItem.new(user_item)
    end
  end

  def build_by_gift_id(gift_id)
    gift = Gift.find_by(id: gift_id)
    fail 'gift is not found for' + gift_id.to_s unless gift
    return build_by_item_id(gift.item_id, gift.count)
  end
end

