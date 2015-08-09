class AreaType::Road < AreaType::Base
  attr_reader :area_node, :area_id
  def initialize(player, area_id, road, area_node, battle_encounter)
    @player  = player
    @area_id = area_id
    @road    = road
    @area_node = area_node
    @encountered_enemy = false
    @battle_encounter = battle_encounter
  end

  def get_name
    return @road.name + '[' + @area_node.node_point.to_s + ']'
  end

  def get_render_path
    return 'area/road'
  end

  # 繋がっているarea_node_idを取得する。
  # 道なので、今の接続点から+1, -1
  def next_to_area_node_id
    max_connect_point = @road.road_length
    min_connect_point = 1
    current = @area_node.node_point
    next_to = []
    # くだりがある。
    if current > min_connect_point
      down = @area_node.id - 1
      next_to.push(down)
    end
    if current < max_connect_point
      up = @area_node.id + 1
      next_to.push(up)
    end
    return next_to
  end

  def get_render_object
    return {
      area_id: @area_id,
      encountered_enemy: @encountered_enemy
    }
  end

  def execute
    @encountered_enemy = @battle_encounter.encount
  end

  def can_move_to_next
    return false if @encountered_enemy

    return true
  end
end

