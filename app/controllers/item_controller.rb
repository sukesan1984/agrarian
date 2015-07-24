class ItemController < ApplicationController
  before_action :authenticate_user!
  def index
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    # player
    @player_character = player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?

    soldier_character_facotry = SoldierCharacterFactory.new
    trait_factory = TraitFactory.new(@player_character, soldier_character_facotry)
    item_consumption_service_factory = ItemConsumptionServiceFactory.new(trait_factory)

    @user_items = UserItem.where('player_id = ?', @player_character.player.id).select { |user_item| user_item.count > 0 }
    @item_consumption_services = item_consumption_service_factory.build_list_by_player_id(@player_character.id)
  end

  def use
    @user_item_id = params[:user_item_id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    redirect_to '/player/input' if @player_character.nil?

    # ターゲットがあるか
    soldier_character_facotry = SoldierCharacterFactory.new
    trait_factory = TraitFactory.new(@player_character, soldier_character_facotry)
    item_consumption_service_factory = ItemConsumptionServiceFactory.new(trait_factory)

    # user_itemを取得
    user_item = UserItem.find_by(id: @user_item_id, player_id: @player_character.id)
    fail 'no such user item' + @user_item_id.to_s + 'for player_id: ' + @player_character.id.to_s unless user_item

    item_consumption_service = item_consumption_service_factory.build_by_player_id_and_user_item(@player_character.id, user_item)

    @targets = item_consumption_service.targets
  end

  def use_actual
    @user_item_id = params[:user_item_id]
    target_type  = params[:target_type]
    target_id    = params[:target_id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    redirect_to '/player/input' if @player_character.nil?

    soldier_character_facotry = SoldierCharacterFactory.new
    trait_factory = TraitFactory.new(@player_character, soldier_character_facotry)
    item_consumption_service_factory = ItemConsumptionServiceFactory.new(trait_factory)

    # user_itemを取得
    user_item = UserItem.find_by(id: @user_item_id, player_id: @player_character.id)
    fail 'no such user item: ' + @user_item_id.to_s + ' for player_id: ' + @player_character.id.to_s unless user_item

    item_consumption_service = item_consumption_service_factory.build_by_player_id_and_user_item(@player_character.id, user_item)

    @result = item_consumption_service.use(target_type, target_id)

    @targets = item_consumption_service.targets

    render template: 'shop/index'
  end

  def sell
    shop_id      = params[:shop_id]
    user_item_id = params[:user_item_id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    user_item_service_factory = UserItemServiceFactory.new(@player_character)
    @user_item_service = user_item_service_factory.build_by_user_item_id(user_item_id)

    @user_item_service.sell
    ActiveRecord::Base.transaction do
      @user_item_service.save!
    end
  end
end

