class RoadViewModel < AreaBaseViewModel
  def initialize(area_id, road)
    @area_id = area_id
    @road    = road
  end

  def get_name
    return @road.name
  end

  def get_area_id
    return @area_id
  end

  def get_render_path
    return "area/road"
  end

  def get_render_object
    return {
      id: 2,
      contents: "fuga"
    }
  end
end
