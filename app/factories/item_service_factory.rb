class ItemServiceFactory
  def initialize(player)
    @player = player
  end

  def build_by_item_id(item_id)
    user_item = UserItem.find_or_create(@player.id, item_id)
    return Item::ConsumeItem.new(user_item, 1)
  end
end
