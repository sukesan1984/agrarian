class ItemPickupServiceFactory
  def initialize
  end

  def build_by_user_item_and_area_node(user_item, area_node)

    thrown_item = ThrownItem.get_or_new_by_area_node_id_and_item_id(area_node.id, user_item.item.id)

    return Item::ItemPickupService.new(user_item, thrown_item)
  end
end
