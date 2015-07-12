class AreaType::Town < AreaType::Base
  attr_reader :area_node, :area_id
  def initialize(
    area_id, 
    town, 
    town_bulletin_boards, 
    area_node,
    establishment_list)
    @area_id = area_id
    @town    = town
    @town_bulletin_boards = town_bulletin_boards
    @area_node = area_node
    @establishment_list = establishment_list
  end

  def get_id
    return @town.id
  end

  def get_name
    return @town.name
  end

  def next_to_area_node_id
  end

  def get_render_path
    return "area/town"
  end

  # 部分templateに渡すやつ
  def get_render_object
    return {
      area_node_id: @area_node.id,
      town_bulletin_boards: @town_bulletin_boards,
      establishment_list: @establishment_list
    }
  end
end
