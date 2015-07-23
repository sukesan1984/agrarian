class Shop::ShowcaseService
  attr_reader :resource_service
  def initialize(resource_service, area_node_id, showcase)
    @resource_service = resource_service
    @area_node_id = area_node_id
    @showcase = showcase
  end

  def name 
    return @showcase.resource.item.name
  end

  def description
    return @showcase.resource.item.description
  end

  def cost
    return @showcase.cost
  end

  def area_node_id
    return @area_node_id
  end

end
