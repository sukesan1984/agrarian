# 装備品
# 装備されているものとして扱っている。
class Entity::EquippedEntity
  def initialize(body_part, equipment_entity)
    @body_part = body_part
    @equipment_entity = equipment_entity
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
    return 'なし' if @equipment_entity.nil?

    return @equipment_entity.name
  end

  def equipped
    return !@equipment_entity.nil?
  end

  def set_equipped(value)
    if @equipment_entity.nil?
      fail 'cant equip nil equipment' if value

      return
    end

    @equipment_entity.set_equipped(value)
  end

  def status
    return Status.new(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) if @equipment_entity.nil?
    return @equipment_entity.status
  end

  def user_item_id
    return nil if @equipment_entity.nil?

    return @equipment_entity.user_item_id
  end

  def save!
    @equipment_entity.save! if @equipment_entity
  end
end

