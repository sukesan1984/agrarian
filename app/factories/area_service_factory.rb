class AreaServiceFactory
  def initialize(resource_service_factory, resource_action_service_factory)
    @resource_service_factory = resource_service_factory
    @resource_action_service_factory = resource_action_service_factory
    @establishment_factory = EstablishmentFactory.new
  end

  def build(area_node)
    area = area_node.area
    case area.area_type
    when 1
      town = Town.find_by(id: area.type_id)
      if(town != nil)
        town_bulletin_boards = TownBulletinBoard.where("town_id = ?", town.id).order(created_at: :desc).limit(5)
        establishment_list = @establishment_factory.build_by_town_id(town.id)
        return AreaType::Town.new(area.id, town, town_bulletin_boards, area_node, establishment_list)
      end
    when 2
      road = Road.find_by(id: area.type_id)
      if(road != nil)
        return AreaType::Road.new(area.id, road, area_node)
      end
    when 3
      nature_field = NatureField.find_by(id: area.type_id)
      if(nature_field != nil)
        resource_service = @resource_service_factory.build_by_target_id_and_resource(area_node.id, nature_field.resource)
        resource_action_service = @resource_action_service_factory.build_by_resource_service_and_action(resource_service, nature_field.harvest)
        return AreaType::NatureField.new(area.id, nature_field, area_node, resource_action_service)
      end
    when 4
      dungeon = Dungeon.find_by(id: area.type_id)
      if(dungeon  != nil)
        return AreaType::Dungeon.new(area.id, dungeon, area_node)
      end
    end

    return AreaType::Null.new()
  end

  # area_idから生成する
  def build_by_area_node_id(area_node_id)
    area_node = AreaNode.find_by(id: area_node_id)
    if(area_node == nil)
      return AreaType::Null.new()
    end

    if(area_node.area == nil)
      return AreaType::Null.new()
    end
    return self.build(area_node)
  end
end
