class AreaViewModelFactory
  def build(area_node)
    area = area_node.area
    case area.area_type
    when 1
      town = Town.find_by(id: area.type_id)
      if(town != nil)
        town_bulletin_boards = TownBulletinBoard.where("town_id = ?", town.id).order(created_at: :desc).limit(5)
        return TownViewModel.new(area.id, town, town_bulletin_boards, area_node)
      end
    when 2
      road = Road.find_by(id: area.type_id)
      if(road != nil)
        return RoadViewModel.new(area.id, road, area_node)
      end
    end

    return NullAreaViewModel.new()
  end

  # area_idから生成する
  def build_by_area_node_id(area_node_id)
    area_node = AreaNode.find_by(id: area_node_id)
    if(area_node == nil)
      return NullAreaViewModel.new()
    end

    if(area_node.area == nil)
      return NullAreaViewModel.new()
    end
    return self.build(area_node)
  end
end
