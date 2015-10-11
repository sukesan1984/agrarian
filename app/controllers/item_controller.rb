class ItemController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
    @user_items = UserItem.where('player_id = ?', @player_character.player.id).select { |user_item| user_item.count > 0 }
    @item_entities = @item_entity_factory.build_by_user_items(@user_items)
    @item_consumption_services = @item_consumption_service_factory.build_list_by_player_id(@player_character.id)
  end

  def use
    @user_item_id = params[:user_item_id]

    # user_itemを取得
    user_item = get_valid_user_item(@player_character.id, @user_item_id)

    item_consumption_service = @item_consumption_service_factory.build_by_player_id_and_user_item(@player_character.id, user_item)
    @targets = item_consumption_service.targets
  end

  def use_actual
    @user_item_id = params[:user_item_id]
    target_type  = params[:target_type]
    target_id    = params[:target_id]

    # user_itemを取得
    user_item = get_valid_user_item(@player_character.id, @user_item_id)

    item_consumption_service = @item_consumption_service_factory.build_by_player_id_and_user_item(@player_character.id, user_item)
    @result = item_consumption_service.use(target_type, target_id)
    @targets = item_consumption_service.targets

    render template: 'item/use/'
  end

  def sell
    # TODO: 将来的にはどの店に売ったかを記録してそれを販売するようにする。
    # shop_id      = params[:shop_id]
    user_item_id = params[:user_item_id]

    item_sale_service_factory = ItemSaleServiceFactory.new(@player_character)
    @item_sale_service = item_sale_service_factory.build_by_user_item_id(user_item_id)

    @result = @item_sale_service.sell
  end

  def throw
    user_item_id = params[:user_item_id]
    user_item = get_valid_user_item(@player_character.id, user_item_id)

    area_acquisition_service = Area::AreaAcquisitionService.new
    area_node = area_acquisition_service.get_current_area_node_by_player_id(@player_character.id)

    item_throw_service = ItemThrowServiceFactory.new(@equipped_list_entity_factory).build_by_user_item_and_area_node_and_player_id(user_item, area_node, @player_character.id)

    @result = item_throw_service.throw
  end

  def pickup
    area_node_id = params[:area_node_id]
    item_id = params[:item_id]

    user_item = @user_item_factory.build_by_player_id_and_item_id(@player_character.id, item_id)

    area_node = Area::AreaAcquisitionService.new.get_by_area_node_id(area_node_id)

    item_pickup_service = ItemPickupServiceFactory.new.build_by_user_item_and_area_node(user_item, area_node)
    @result = item_pickup_service.pickup
  end

  private

  def set_factories
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    @equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    @soldier_character_facotry = SoldierCharacterFactory.new(@equipped_list_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(@equipped_list_entity_factory)
    @trait_factory = TraitFactory.new(@player_character_factory, @soldier_character_facotry)
    @item_consumption_service_factory = ItemConsumptionServiceFactory.new(@trait_factory)
    @user_item_factory = UserItemFactory.new(@equipped_list_entity_factory)
    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(@user_item_factory)
    quest_entity_factory = Quest::QuestEntityFactory.new(@player_character_factory, quest_condition_entity_factory)
    @item_entity_factory = ItemEntityFactory.new(@player_character_factory, @user_item_factory, quest_entity_factory, equipment_entity_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end

  def get_valid_user_item(player_id, user_item_id)
    user_item = UserItem.find_by(id: user_item_id, player_id: player_id)
    fail 'no such user item' + user_item_id.to_s + 'for player_id: ' + player_id.to_s unless user_item
    return user_item
  end
end

