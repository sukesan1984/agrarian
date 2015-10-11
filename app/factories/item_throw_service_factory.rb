class ItemThrowServiceFactory
  def initialize(equipped_list_entity_factory, item_entity_factory)
    @equipped_list_entity_factory = equipped_list_entity_factory
    @item_entity_factory = item_entity_factory
  end

  # 有効なuser_itemとarea_nodeを渡す
  # 事前にプレイヤーのuser_itemである事は保証してね
  def build_by_user_item_and_area_node_and_player_id(user_item, area_node, player_id)
    equipped_list_entity = @equipped_list_entity_factory.build_by_player_id(player_id)

    # 装備品の時だけ、user_item_idを指定する
    thrown_item = nil
    case user_item.item.item_type
    when 2
      thrown_item = ThrownItem.get_or_new_by_area_node_id_and_item_id_and_user_item_id(area_node.id, user_item.item.id, user_item.id)
    else
      thrown_item = ThrownItem.get_or_new_by_area_node_id_and_item_id(area_node.id, user_item.item.id)
    end

    item_entity = @item_entity_factory.build_by_user_item(user_item)
    return Item::ItemThrowService.new(item_entity, thrown_item, equipped_list_entity)
  end
end

