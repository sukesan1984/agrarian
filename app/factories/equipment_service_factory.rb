class EquipmentServiceFactory

  ABILITY_ID = 100001

  def initialize
  end

  def build_list_by_player_id(player_id)
    # 装備可能属性を持つアイテムを抽出
    # ItemAbilityListから、抽出して、それらのうちユーザーがもっているものの判定にする。
    # その方が多分キャッシュ効かせられる。
    item_ability_lists = ItemAbilityList.where(item_ability_id: ABILITY_ID)

    user_items = UserItem.where('player_id = ? and item_id in (?)', player_id, item_ability_lists.map{|item_ability_list| item_ability_list.item_id})

    equipment_services = Array.new
    user_items.each do |user_item|
      equipment_services.push(EquipmentService.new(user_item))
    end

    return equipment_services
  end
end