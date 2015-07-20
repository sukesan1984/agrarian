#装備品
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
    if @equipment_service.nil?
      return 'なし'
    end

    return @equipment_service.name
  end

  def equipped
    return @equipment_service != nil
  end

  def status
    if(@equipment_service.nil?)
       return Status.new(0, 0)
    end
    return @equipment_service.status
  end

  def user_item_id
    if @equipment_service.nil?
      return nil
    end

    return @equipment_service.user_item_id
  end

end
