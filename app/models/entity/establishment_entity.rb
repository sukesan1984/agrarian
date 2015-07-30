class Entity::EstablishmentEntity 
  def initialize(establishment, area_node_id, master)
    @area_node_id = area_node_id
    @establishment = establishment
    @master = master
  end

  def id 
    return @master.id
  end

  def name
    return @master.name
  end

  def description
    return @master.description
  end
end

