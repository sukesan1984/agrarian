class ItemSaleServiceFactory
  def initialize(player)
    @player = player
  end

  def build_by_user_item_id(user_item_id)
    user_item = UserItem.find_by(id: user_item_id, player_id: @player.id)
    fail 'user does not have this item: ' + user_item_id.to_s unless user_item

    return Item::ItemSaleService.new(@player, user_item)
  end
end

