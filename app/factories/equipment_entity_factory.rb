class EquipmentEntityFactory
  ABILITY_ID = 100001

  def initialize
  end

  def build_list_by_player_id(player_id)
    # 装備可能属性を持つアイテムを抽出
    # ItemAbilityListから、抽出して、それらのうちユーザーがもっているものの判定にする。
    # その方が多分キャッシュ効かせられる。
    item_ability_lists = ItemAbilityList.where(item_ability_id: ABILITY_ID)

    user_items = UserItem.where('player_id = ? and item_id in (?)', player_id, item_ability_lists.map(&:item_id))
                 .select { |user_item| user_item.equipped == 0 }

    equipment_entitys = []
    user_items.each do |user_item|
      next if user_item.count == 0
      equipment_entitys.push(build_by_user_item(user_item))
    end

    return equipment_entitys
  end

  def build_by_user_item(user_item)
    equipment = Equipment.find_by(item_id: user_item.item_id)
    fail 'no such item' unless equipment
    return Entity::EquipmentEntity.new(user_item, equipment)
  end
end

