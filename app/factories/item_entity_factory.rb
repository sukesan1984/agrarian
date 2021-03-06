class ItemEntityFactory
  def initialize(player_character_factory, user_item_factory, quest_entity_factory, equipment_entity_factory)
    @player_character_factory = player_character_factory
    @user_item_factory = user_item_factory
    @quest_entity_factory = quest_entity_factory
    @equipment_entity_factory = equipment_entity_factory
  end

  def build_by_player_id_and_item_id_and_count(player_id, item_id, count)
    item = Item.find_by(id: item_id)
    fail 'invalid item_id: ' + item_id.to_s unless item

    player = @player_character_factory.build_by_player_id(player_id)
    fail 'no player: ' + player_id.to_s unless player

    user_item = @user_item_factory.build_by_player_id_and_item(player.id, item)

    case item.item_type
    when 1, 4
      return Entity::Item::ConsumeItemEntity.new(user_item, count, user_item.item)
    when 2
      return @equipment_entity_factory.build_by_user_item(user_item)
    when 3
      soldier = Soldier.find_by(id: item.item_type_id)
      if soldier.nil?
        fail 'no soldier: ' + item.item_type_id
      end
      return Entity::Item::SoldierItemEntity.new(player, soldier, item_id)
    when 5
      quest_entity = @quest_entity_factory.build_by_user_quest_and_player_id(user_item, player.id)
      return Entity::Item::QuestItemEntity.new(quest_entity, item_id)
    when 6
      return Entity::Item::MoneyItemEntity.new(player, count, item_id)
    end
  end

  def build_by_player_id_and_gift_id(player_id, gift_id)
    gift = Gift.find_by(id: gift_id)
    fail 'gift is not found for' + gift_id.to_s unless gift
    return build_by_player_id_and_item_id_and_count(player_id, gift.item_id, gift.count)
  end

  def build_by_user_items(user_items)
    item_entities = []
    user_items.each do |user_item|
      item_entities.push self.build_by_user_item(user_item)
    end

    return item_entities
  end

  def build_by_user_item(user_item)
    case user_item.item.item_type
    when 1, 4
      return Entity::Item::ConsumeItemEntity.new(user_item, 0, user_item.item)
    when 2
      return @equipment_entity_factory.build_by_user_item(user_item)
    else
      # user_item系は、1, 4, 2
      fail "item_type must be 1, 4, 2 but: #{user_item.item.item_type}"
    end
  end

  def build_by_thrown_items(thrown_items)
    item_entities = []
    thrown_items.each do |thrown_item|
      item_entities.push self.build_by_player_id_and_thrown_item(0, thrown_item)
    end
    return item_entities
  end

  def build_by_player_id_and_thrown_item(player_id, thrown_item)
      case thrown_item.item.item_type
      when 1, 4
        user_item = @user_item_factory.build_by_player_id_and_item_id(player_id, thrown_item.item_id)
        return Entity::Item::ConsumeItemEntity.new(user_item, thrown_item.count, thrown_item.item)
      when 2
        user_item = @user_item_factory.build_by_player_id_and_user_item_id(0, thrown_item.user_item_id)
        return @equipment_entity_factory.build_by_user_item(user_item)
      else
        # TODO: user_itemのみ捨てれるを修正する場合は、ここやれる
        fail "item_type must be 1, 4, 2 but: #{user_item.item.item_type}"
      end
  end
end

