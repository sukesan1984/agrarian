class TownViewModel < AreaBaseViewModel
  def initialize(area_id, town, town_bulletin_boards)
    @area_id = area_id
    @town    = town
    @town_bulletin_boards = town_bulletin_boards
  end

  def get_id
    return @town.id
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

  # 部分templateに渡すやつ
  def get_render_object
    return @town_bulletin_boards
  end
end
