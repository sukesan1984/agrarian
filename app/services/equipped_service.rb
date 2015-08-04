# 装備品
class EquippedService
  def initialize(body_part, equipment_service)
    @body_part = body_part
    @equipment_service = equipment_service
  end

  def part_name
    return @body_part.name
  end

  def part_variable_name
    return @body_part.variable_name
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

  def set_equipped(value)
    if @equipment_service.nil?
      if value 
        fail 'cant equip nil equipment'
      end

      return
    end

    @equipment_service.set_equipped(value)
  end

  def status
    return Status.new(0, 0) if @equipment_service.nil?
    return @equipment_service.status
  end

  def user_item_id
    return nil if @equipment_service.nil?

    return @equipment_service.user_item_id
  end

  def save!
    if @equipment_service
      @equipment_service.save!
    end
  end
end

