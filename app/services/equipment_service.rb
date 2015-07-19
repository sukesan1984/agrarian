# 装備奴
class EquipmentService
  def initialize(user_item)
    @user_item = user_item
  end

  def name
    return @user_item.item.name
  end
end

