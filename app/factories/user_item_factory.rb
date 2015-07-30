class UserItemFactory
  def initialize(equipped_list_service_factory)
    @equipped_list_service_factory = equipped_list_service_factory
  end

  # userが装備してないアイテムのリストを取得する。
  def build_unequipped_user_item_list_by_player_id(player_id)
    equipped_list_service = @equipped_list_service_factory.build_by_player_id(player_id)
    user_items = UserItem.where(player_id: player_id)
                 .select { |user_item| user_item.count > 0 }
                 .select { |user_item| !equipped_list_service.equipped(user_item.id) }
    return user_items
  end
end

