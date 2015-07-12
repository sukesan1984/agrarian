class AreaType::NatureField < AreaType::Base
  attr_reader :area_node, :area_id
  def initialize(area_id, nature_field, area_node, resource_action_service)
    @area_id = area_id
    @nature_field = nature_field
    @area_node = area_node
    @resource_action_service = resource_action_service
  end

  def get_id
    return @nature_field.id
  end

  def get_name
    return @nature_field.name
  end
  
  def next_to_area_node_id
  end

  def has_resource_action
    return true
  end

  def resource_action_execute
    return @resource_action_service.execute
  end

  def get_render_path
    return "area/nature_field"
  end

  def get_render_object
    return {
      area_node_id: @area_node.id,
      description: @nature_field.description,
      harvest: @nature_field.harvest,
      current_count: @resource_action_service.current_count
    }
  end
end
