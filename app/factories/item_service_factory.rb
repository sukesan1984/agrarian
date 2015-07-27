class ItemServiceFactory
  def initialize(player)
    @player = player
  end

  def build_by_item_id(item_id, count)
    item = Item.find_by(id: item_id)
    case item.item_type
    when 1, 2, 4
      user_item = UserItem.find_or_create(@player.id, item_id)
      return Item::ConsumeItem.new(user_item, count)
    when 3
      soldier = Soldier.find_by(id: item.item_type_id)
      return Item::SoldierItem.new(@player, soldier)
    when 5
      user_quest = UserQuest.find_or_create(@player.id, item.item_type_id)
      return Item::QuestItem.new(user_quest)
    end
  end

  def build_by_gift_id(gift_id)
    gift = Gift.find_by(id: gift_id)
    fail 'gift is not found for' + gift_id.to_s unless gift
    return build_by_item_id(gift.item_id, gift.count)
  end
end

