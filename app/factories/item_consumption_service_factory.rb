class ItemConsumptionServiceFactory
  
  ABILITY_ID = 200001

  def initialize(trait_factory)
    @trait_factory = trait_factory
  end

  def build_list_by_player_id(player_id)
    # 消費することができるアイテムを検索
    item_ability_lists = ItemAbilityList.where(item_ability_id: ABILITY_ID)

    user_items = UserItem.where('player_id = ? and item_id in (?)', player_id, item_ability_lists.map{|item_ability_list| item_ability_list.item_id})
    item_consumption_services = Array.new
    user_items.each do |user_item|
      #パフォーマンスはおいおい
      consumption = Consumption.find_by(item_id: user_item.item.id)
      trait = @trait_factory.build_by_comsumption_and_target(consumption, nil)
      item_consumption_services.push(ItemConsumptionService.new(user_item, trait))
    end

    return item_consumption_services
  end
end
