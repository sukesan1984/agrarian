class RoadViewModel < AreaBaseViewModel
  attr_reader :area_node, :area_id
  def initialize(area_id, road, area_node)
    @area_id = area_id
    @road    = road
    @area_node = area_node
  end

  def get_name
    return @road.name + "[" + @area_node.node_point.to_s() + "]"
  end

  def get_render_path
    return "area/road"
  end

  # 繋がっているarea_node_idを取得する。
  # 道なので、今の接続点から+1, -1
  def next_to_area_node_id
    max_connect_point = @road.road_length
    min_connect_point = 1
    current = @area_node.node_point 
    next_to = Array.new
    #くだりがある。
    if(current > min_connect_point)
      down = @area_node.id - 1
      next_to.push(down)
    end
    if(current < max_connect_point)
      up = @area_node.id + 1
      next_to.push(up)
    end
    return next_to
  end

  def get_render_object
    return {
      id: 2,
      contents: "fuga"
    }
  end
end
