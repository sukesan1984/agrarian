class AreaServiceFactory
  def initialize(player_character_factory, resource_service_factory, resource_action_service_factory, battle_encounter_factory)
    @player_character_factory = player_character_factory
    @resource_service_factory = resource_service_factory
    @resource_action_service_factory = resource_action_service_factory
    @establishment_entity_factory = EstablishmentEntityFactory.new
    @battle_encounter_factory = battle_encounter_factory
  end

  def build_by_area_node_and_player_id(area_node, player_id)
    area = area_node.area
    player = @player_character_factory.build_by_player_id(player_id)
    case area.area_type
    when 1
      return build_town_service(area_node)
    when 2
      return build_road_service(area_node, player)
    when 3
      return build_nature_field_service(area_node, player)
    when 4
      return build_dungeon_service(area_node)
    end
    return AreaType::Null.new
  end

  # area_idから生成する
  def build_by_area_node_id_and_player_id(area_node_id, player_id)
    area_node = AreaNode.find_by(id: area_node_id)
    return AreaType::Null.new if area_node.nil?

    return AreaType::Null.new if area_node.area.nil?
    return build_by_area_node_and_player_id(area_node, player_id)
  end

  # playerの現在地からtarget_routesを取得する
  def build_target_routes_by_player_id(player_id)
    user_area = UserArea.get_or_create(player_id)
    return build_target_routes_by_area_node_id_and_player_id(user_area.area_node_id, player_id)
  end

  def build_target_routes_by_area_node_id_and_player_id(area_node_id, player_id)
    routes = Route.where(area_node_id: area_node_id)
    target_routes = []
    routes.each do |route|
      target_routes.push(build_by_area_node_id_and_player_id(route.connected_area_node_id, player_id))
    end

    current = build_by_area_node_id_and_player_id(area_node_id, player_id)

    # nilじゃなかったら、each
    if current.next_to_area_node_id
      current.next_to_area_node_id.each do |next_area_node_id|
        target_routes.push(build_by_area_node_id_and_player_id(next_area_node_id, player_id))
      end
    end

    return target_routes
  end

  private
  def build_town_service(area_node)
    town = Town.find_by(id: area_node.area.type_id)
    unless town.nil?
      town_bulletin_boards = TownBulletinBoard.where('town_id = ?', town.id).order(created_at: :desc).limit(5)
      establishment_list = @establishment_entity_factory.build_by_town_id(town.id)
      return AreaType::Town.new(area_node.area.id, town, town_bulletin_boards, area_node, establishment_list)
    end
    return AreaType::Null.new
  end

  def build_road_service(area_node, player)
    road = Road.find_by(id: area_node.area.type_id)
    unless road.nil?
      battle_encounter = @battle_encounter_factory.build_by_area_id_and_player_id(area_node.area.id, player.id)
      return AreaType::Road.new(player, area_node.area.id, road, area_node, battle_encounter)
    end
    return AreaType::Null.new
  end

  def build_nature_field_service(area_node, player)
    nature_field = NatureField.find_by(id: area_node.area.type_id)
    unless nature_field.nil?
      resource_service = @resource_service_factory.build_by_target_id_and_resource(area_node.id, nature_field.resource)
      resource_action_service = @resource_action_service_factory.build_by_resource_service_and_action_and_player_id(resource_service, nature_field.resource_action, player.id)
      return AreaType::NatureField.new(area_node.area.id, nature_field, area_node, resource_action_service)
    end
    return AreaType::Null.new
  end

  def build_dungeon_service(area_node)
    dungeon = Dungeon.find_by(id: area_node.area.type_id)
    unless dungeon.nil?
      return AreaType::Dungeon.new(area_node.area.id, dungeon, area_node)
    end
    return AreaType::Null.new
  end
end

