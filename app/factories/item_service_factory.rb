class ItemServiceFactory
  def initialize(player)
    @player = player
  end

  def build_by_item_id(item_id)
    item = Item.find_by(id: item_id)
    case item.item_type
    when 1..2
      user_item = UserItem.find_or_create(@player.id, item_id)
      return Item::ConsumeItem.new(user_item, 1)
    when 3
      soldier = Soldier.find_by(id: item.item_type_id)
      return Item::SoldierItem.new(@player, soldier)
    end
  end
end
