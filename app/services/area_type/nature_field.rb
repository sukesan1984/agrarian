class AreaType::NatureField < AreaType::Base
  attr_reader :area_node, :area_id
  def initialize(area_id, nature_field, area_node, resource_service)
    @area_id = area_id
    @nature_field = nature_field
    @area_node = area_node
    @resource_service = resource_service
  end

  def get_id
    return @nature_field = id
  end

  def get_name
    return @nature_field.name
  end

  def has_action
    return true
  end

  def action
    return @nature_field.action
  end

  def next_to_area_node_id
  end

  def get_render_path
    return "area/nature_field"
  end

  def get_render_object
    return {
      area_node_id: @area_node.id,
      description: @nature_field.description,
      action: @nature_field.action,
      current_count: @resource_service.current_count
    }
  end
end
