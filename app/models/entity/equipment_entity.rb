# 装備奴
# 装備される前のやつ
class Entity::EquipmentEntity
  attr_reader :status
  def initialize(user_item, equipment)
    @user_item = user_item
    @equipment = equipment
    @status    = Status.new(equipment.attack, equipment.defense, 0, 0, 0, 0, 0, 0, 0, 0, 0)
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

  def user_item_id
    return @user_item.id
  end

  def set_equipped(value)
    if value
      @user_item.equipped = 1
    else
      @user_item.equipped = 0
    end
  end

  def save!
    @user_item.save!
  end
end

