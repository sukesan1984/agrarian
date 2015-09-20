class ItemThrowServiceFactory
  def initialize(equipped_list_entity_factory)
    @equipped_list_entity_factory = equipped_list_entity_factory
  end

  # 有効なuser_itemとarea_nodeを渡す
  # 事前にプレイヤーのuser_itemである事は保証してね
  def build_by_user_item_and_area_node_and_player_id(user_item, area_node, player_id)
    equipped_list_entity = @equipped_list_entity_factory.build_by_player_id(player_id)

    thrown_item = ThrownItem.get_or_new_by_area_node_id_and_item_id(area_node.id, user_item.item.id)
    return Item::ItemThrowService.new(user_item, thrown_item, equipped_list_entity)
  end
end

