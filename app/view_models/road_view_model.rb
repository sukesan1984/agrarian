class RoadViewModel < AreaBaseViewModel
  def initialize(area_id, road)
    @area_id = area_id
    @road    = road
  end

  def get_name
    return @road.name
  end

  def get_redirect_to
    return "/roads/" + @road.id.to_s()
  end

  def get_area_id
    return @area_id
  end
end
