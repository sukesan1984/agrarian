class ResourceActionServiceFactory
  def initialize(player_character_factory)
    @player_character_factory = player_character_factory
  end

  def build_by_resource_service_and_action_and_player_id(resource_service, resource_action, player_id)
    player = @player_character_factory.build_by_player_id(player_id)
    user_item = nil
    if resource_service.item
      user_item = UserItem.find_or_create(player.id, resource_service.item.id)
    end

    case (resource_action.action_type)
    when 1
      harvest = Harvest.find_by(id: resource_action.action_id)
      if harvest
        lists = harvest.item_ability.item_ability_lists
        user_items = UserItem.where('player_id = ? and item_id in (?)', player.id, lists.map(&:item_id))
        return ResourceAction::ResourceHarvestService.new(resource_service, harvest, user_item, user_items)
      end
    end
  end
end

