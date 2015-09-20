# 装備奴
# 装備される前のやつ
class Entity::EquipmentEntity
  attr_reader :status
  def initialize(user_item, equipment)
    @user_item = user_item
    @user_equipment_affix_list = Entity::UserEquipmentAffixListEntity.new(@user_item.user_equipment_affixes)
    @equipment = equipment
    self.update_affix_status
  end

  def has_affixes
    return @user_equipment_affix_list.has_affixes
  end

  def apply_magic(user_equipment_affixes)
    return if self.has_affixes

    @user_equipment_affix_list = Entity::UserEquipmentAffixListEntity.new(user_equipment_affixes)
    self.update_affix_status
  end

  def name
    return @user_equipment_affix_list.name + @user_item.item.name
  end

  def descriptions
    return @status.descriptions
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
    @user_equipment_affix_list.save!
  end

  def update_affix_status
    @status    = Status.new(@equipment.attack, @equipment.defense, 0, 0, 0, 0, 0, 0, 0, 0, 0) + @user_equipment_affix_list.status
  end
end

