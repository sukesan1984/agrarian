class ResourceActionServiceFactory
  def initialize(player)
    @player = player
  end

  def build_by_resource_service_and_action(resource_service, action)
    user_item = nil
    if(resource_service.item)
      user_item = UserItem.find_or_create(@player.id, resource_service.item.id)
    end

    return ResourceActionService.new(resource_service, action, user_item)
  end
end
