class Area::AreaAcquisitionService
  def initialize()
  end

  def get_current_area_node_by_player_id(player_id)
    current_area_node_id = UserArea.get_current_or_create(player_id) 
    area_node = AreaNode.find_by(id: current_area_node_id)
    fail 'no such area_node_id: ' + current_area_node_id.to_s unless area_node
    return area_node
  end
end

