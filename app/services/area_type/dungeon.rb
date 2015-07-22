class AreaType::Dungeon < AreaType::Base
  attr_reader :area_node, :area_id
  def initialize(area_id, dungeon, area_node)
    @area_id = area_id
    @dungeon = dungeon
    @area_node = area_node
  end

  def get_id
    returen @dungeon.id
  end

  def get_name
    return @dungeon.name
  end

  def get_render_path
    return 'area/dungeon'
  end

  def get_render_object
  end
end

