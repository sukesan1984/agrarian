class ResourceActionServiceFactory
  def initialize(player)
    @player = player
  end

  def build_by_resource_service_and_action(resource_service, resource_action)
    user_item = nil
    if(resource_service.item)
      user_item = UserItem.find_or_create(@player.id, resource_service.item.id)
    end

    case(resource_action.action_type)
    when 1
      harvest = Harvest.find_by(id:resource_action.action_id)
      if(harvest)
        return ResourceAction::ResourceHarvestService.new(resource_service, harvest, user_item)
      end
    end
  end
end
