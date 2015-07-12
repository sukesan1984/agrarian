class ResourceServiceFactory
  def initialize
  end

  def build_by_target_id_and_resource(target_id, resource)
    resource_keeper = ResourceKeeper.find_by(target_id: target_id, resource_id: resource.id)
    if(resource_keeper.nil?)
      resource_keeper = ResourceKeeper.create(
        target_id: target_id,
        resource_id: resource.id,
        current_count: 0,
        last_recovered_at: Time.now
      )
    end
    return ResourceService.new(resource, resource_keeper)
  end
end
