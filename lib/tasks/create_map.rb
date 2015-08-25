require 'gviz'

class Tasks::CreateMap
  def self.execute
    gv = Gviz.new
    @routes = Route.all
    @routes.each do |route|
      area_node = AreaNode.find_by(id: route.area_node_id)
      area = self.get_by_area_id(area_node.area_id)
      concrete = self.build_by_area(area)

      connected_area_node = AreaNode.find_by(id: route.connected_area_node_id)
      connected_area = self.get_by_area_id(connected_area_node.area_id)
      concrete_area = self.build_by_area(connected_area)

      gv.add route.area_node_id.to_s.to_sym => route.connected_area_node_id

      gv.node route.area_node_id.to_s.to_sym, label: concrete.name
      gv.node route.connected_area_node_id.to_s.to_sym, label: concrete_area.name
    end

    # roadをつなぐ
    areas = Area.where(area_type: 2)
    areas.each do |area|
      concrete = self.build_by_area(area)
      area_nodes = AreaNode.where(area_id: area.id)
      area_nodes.each_with_index {|area_node, index|
        if index == area_nodes.length - 1
          next
        end

        gv.add area_node.id.to_s.to_sym => area_nodes[index+1].id.to_s.to_sym
        gv.add area_nodes[index+1].id.to_s.to_sym => area_node.id.to_s.to_sym

        gv.node area_node.id.to_s.to_sym, label: "#{concrete.name}[#{area_node.node_point}]", font_size: 1
        gv.node area_nodes[index+1].id.to_s.to_sym, label: "#{concrete.name}[#{area_nodes[index+1].node_point}]", font_size: 1

      }
    end
    
    gv.save :map, :png
  end

  def self.get_by_area_id(area_id)
    return Area.find_by(id: area_id)
  end

  def self.build_by_area(area)
    puts("area.id:#{area.id}")
    puts("area.area_type:#{area.area_type}")
    case area.area_type
    when 1
      town = Town.find_by(id: area.type_id)
      puts(town.name)
      return town
    when 2
      road = Road.find_by(id: area.type_id)
      puts(road.name)
      return road
    when 3
      nature_field = NatureField.find_by(id: area.type_id)
      puts(nature_field.name)
      return nature_field
    when 4
      dungeon = Dungeon.find_by(id: area.type_id)
      puts(dungeon.name)
      return dungeon
    end
  end
end
