class TownViewModel < AreaBaseViewModel
  def initialize(area_id, town)
    @area_id = area_id
    @town    = town
  end

  def get_name
    return @town.name
  end

  def get_area_id
    return @area_id
  end

  def get_render_path
    return "area/town"
  end
end

