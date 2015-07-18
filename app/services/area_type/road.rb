class AreaType::Road < AreaType::Base
  attr_reader :area_node, :area_id
  def initialize(player, area_id, road, area_node)
    @player  = player
    @area_id = area_id
    @road    = road
    @area_node = area_node
    @encountered_enemy = false
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
      area_id: @area_id,
      encountered_enemy: @encountered_enemy
    }
  end

  def execute
    enemy_maps = EnemyMap.where("area_id = ?", area_id)
    area = Area.find_by(id: area_id)
    if(enemy_maps.count == 0 || area.nil?)
      return
    end

    enemies_lottery = Battle::EnemiesLottery.new(enemy_maps)
    encounter = Battle::Encounter.new(area, enemies_lottery)

    list = encounter.encount
    if(list.nil?)
      return
    end

    @encountered_enemy = true
    UserEncounterEnemy.delete_all(["player_id = ?", @player.id])
    list.each do |enemy|
      UserEncounterEnemy.create(
        player_id: @player.id,
        enemy_id: enemy.id
      )
    end
  end

  def can_move_to_next
    if(@encountered_enemy)
      return false
    end

    return true
  end
end
