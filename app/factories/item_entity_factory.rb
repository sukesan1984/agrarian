class ItemEntityFactory
  def initialize(player, user_item_factory, quest_entity_factory)
    @player = player
    @user_item_factory = user_item_factory
    @quest_entity_factory = quest_entity_factory
  end

  def build_by_item_id(item_id, count)
    item = Item.find_by(id: item_id)
    fail 'invalid item_id: ' + item_id.to_s unless item

    user_item = @user_item_factory.build_by_player_id_and_item(@player.id, item)

    case item.item_type
    when 1, 2, 4
      return Entity::Item::ConsumeItemEntity.new(user_item, count, item_id)
    when 3
      return Entity::Item::SoldierItemEntity.new(@player, user_item, item_id)
    when 5
      quest_entity = @quest_entity_factory.build_by_user_quest_and_player_id(user_item, @player.id)
      return Entity::Item::QuestItemEntity.new(quest_entity, item_id)
    when 6
      return Entity::Item::MoneyItemEntity.new(@player, count, item_id)
    end
  end

  def build_by_gift_id(gift_id)
    gift = Gift.find_by(id: gift_id)
    fail 'gift is not found for' + gift_id.to_s unless gift
    return build_by_item_id(gift.item_id, gift.count)
  end
end

