class UserItemFactory
  def initialize(equipped_list_entity_factory)
    @equipped_list_entity_factory = equipped_list_entity_factory
  end

  # userが装備してないアイテムのリストを取得する。
  def build_unequipped_user_item_list_by_player_id(player_id)
    equipped_list_entity = @equipped_list_entity_factory.build_by_player_id(player_id)
    user_items = UserItem.where(player_id: player_id)
                 .select { |user_item| user_item.count > 0 }
                 .select { |user_item| !equipped_list_entity.equipped(user_item.id) }
    return user_items
  end

  # item_idが有効かどうかのvalidationとかもやる
  def build_by_player_id_and_item_id(player_id, item_id)
    item = Item.find_by(id: item_id)
    fail 'invalid item_id: ' + item_id.to_s unless item

    return build_by_player_id_and_item(player_id, item)
  end

  def build_by_player_id_and_item(player_id, item)
    case item.item_type
    when 1, 4
      user_item = UserItem.find_or_create(player_id, item.id)
      return user_item
    when 2
      user_item = UserItem.new(
        player_id: player_id,
        item_id: item.id,
        count: 0)
      return user_item
    when 3
      soldier = Soldier.find_by(id: item.item_type_id)
      return soldier
    when 5
      user_quest = UserQuest.find_or_create(player_id, item.item_type_id)
      return user_quest
    end
  end
end

