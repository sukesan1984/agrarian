# 装備奴
# 装備される前のやつ
class Entity::EquipmentEntity < Entity::ItemEntity
  attr_reader :status
  def initialize(user_item, equipment)
    @user_item = user_item
    @user_equipment_affix_list = Entity::UserEquipmentAffixListEntity.new(@user_item.user_equipment_affixes)
    @equipment = equipment
    self.update_affix_status
  end

  def equipped?
    return @user_item.equipped?
  end

  def equipment?
    return true
  end 

  def user_item_id
    return @user_item.id
  end

  def item_id
    return @user_item.item.id
  end

  def count
    return 1
  end

  def current_count
    return @user_item.count
  end

  def give
    @user_item.count = 1
    return true
  end

  # 移す
  def transfer(player_id)
    @user_item.player_id = player_id
  end

  # 捨てる
  def throw
    @user_item.count = 0
    @user_item.player_id = 0
    return true
  end

  def has_affixes
    return @user_equipment_affix_list.has_affixes
  end

  def apply_magic(user_equipment_affixes)
    return if self.has_affixes

    @user_equipment_affix_list = Entity::UserEquipmentAffixListEntity.new(user_equipment_affixes)
    @user_item.user_equipment_affixes = user_equipment_affixes
    self.update_affix_status
  end

  def name
    return @user_equipment_affix_list.name + @user_item.item.name
  end

  def descriptions
    return @status.descriptions
  end

  def attack
    return @status.attack
  end

  def defense
    return @equipment.defense
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

  def result
    return 'ゲットしたで'
  end

  def update_affix_status
    @status    = Status.new(@equipment.damage_min, @equipment.damage_max, 0, @equipment.defense, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) + @user_equipment_affix_list.status
  end
end

