# 装備品
class EquippedService
  def initialize(body_part, equipment_service)
    @body_part = body_part
    @equipment_service = equipment_service
  end

  def part_name
    return @body_part.name
  end

  def part_id
    return @body_part.id
  end

  def name
    return 'なし' if @equipment_service.nil?

    return @equipment_service.name
  end

  def equipped
    return !@equipment_service.nil?
  end

  def status
    return Status.new(0, 0) if @equipment_service.nil?
    return @equipment_service.status
  end

  def user_item_id
    return nil if @equipment_service.nil?

    return @equipment_service.user_item_id
  end
end

