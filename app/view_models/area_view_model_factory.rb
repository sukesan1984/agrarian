class AreaViewModelFactory
  def build(area_id, area_type, type_id)
    case area_type
    when 1
      town = Town.find_by(id: type_id)
      if(town != nil)
        return TownViewModel.new(area_id, town)
      end
    when 2
      road = Road.find_by(id: type_id)
      if(road != nil)
        return RoadViewModel.new(area_id, road)
      end
    end

    return NullAreaViewModel.new()
  end

  # area_idから生成する
  def build_by_area_id(area_id)
    area = Area.find_by(id: area_id)
    if(area == nil)
      return nil
    end
    return self.build(area_id, area.area_type, area.type_id)
  end
end
