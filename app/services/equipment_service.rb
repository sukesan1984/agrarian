# 装備奴
class EquipmentService
  def initialize(user_item, equipment)
    @user_item = user_item
    @equipment = equipment
  end

  def name
    return @user_item.item.name
  end

  def attack
    return @equipment.attack
  end

  def defense
    return @equipment.defense
  end
end
