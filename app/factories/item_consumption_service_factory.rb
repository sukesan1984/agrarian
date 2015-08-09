class ItemConsumptionServiceFactory
  ABILITY_ID = 200001

  def initialize(trait_factory)
    @trait_factory = trait_factory
  end

  def build_list_by_player_id(player_id)
    # 消費することができるアイテムを検索
    item_ability_lists = ItemAbilityList.where(item_ability_id: ABILITY_ID)

    user_items = UserItem.where('player_id = ? and item_id in (?)', player_id, item_ability_lists.map(&:item_id))
    item_consumption_services = []
    user_items.each do |user_item|
      next if user_item.count <= 0
      # パフォーマンスはおいおい
      consumption = Consumption.find_by(item_id: user_item.item.id)
      trait = @trait_factory.build_by_comsumption_and_player_id(consumption, player_id)
      item_consumption_services.push(Item::ItemConsumptionService.new(user_item, trait))
    end

    return item_consumption_services
  end

  def build_by_player_id_and_user_item(player_id, user_item)
    consumption = Consumption.find_by(item_id: user_item.item.id)
    fail 'no consumption :' + user_item.item.id unless consumption
    trait = @trait_factory.build_by_comsumption_and_player_id(consumption, player_id)
    return Item::ItemConsumptionService.new(user_item, trait)
  end
end

