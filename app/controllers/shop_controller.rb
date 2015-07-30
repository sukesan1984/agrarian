class ShopController < ApplicationController
  before_action :set_factories
  before_action :set_shop
  before_action :set_area_node
  before_action :set_resource
  before_action :set_player_character

  def index
    redirect_to player_input_path if @player_character.nil?

    user_item_factory = UserItemFactory.new(@equipped_list_service_factory)

    @showcases = []
    @shop.showcases.each do |showcase|
      @showcases.push(Shop::ShowcaseService.new(@resource_service_factory.build_by_target_id_and_resource(@area_node.id, showcase.resource), @area_node.id, showcase))
    end

    @user_items = user_item_factory.build_unequipped_user_item_list_by_player_id(@player_character.id)
  end

  def buy
    # TODO: validateクラスに寄せる
    redirect_to root_path if @area_node.nil? || @resource.nil? || @shop.nil?
    redirect_to player_input_path if @player_character.nil?

    showcase = Showcase.find_by(shop_id: @shop.id, resource_id: @resource.id)
    fail 'showcase is nil' if showcase.nil?

    resource_service = @resource_service_factory.build_by_target_id_and_resource(@area_node.id, @resource)

    item_service_factory = ItemServiceFactory.new(@player_character)
    item_service = item_service_factory.build_by_item_id(resource_service.item.id, 1)

    resource_purchase_service = ResourceAction::ResourcePurchaseService.new(resource_service, item_service, @player_character.player, showcase)

    @result = resource_purchase_service.execute
    redirect_to root_path unless @result[:success]

    @showcases = []
    @shop.showcases.each do |s|
      @showcases.push(Shop::ShowcaseService.new(@resource_service_factory.build_by_target_id_and_resource(@area_node.id, s.resource), @area_node.id, s))
    end
  end

  private

  def set_factories
    @resource_service_factory      = ResourceServiceFactory.new
    equipment_service_factory      = EquipmentServiceFactory.new
    equipped_service_factory       = EquippedServiceFactory.new(equipment_service_factory)
    @equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    @player_character_factory      = PlayerCharacterFactory.new(@equipped_list_service_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
  end

  def set_shop
    @shop = Shop.find(params[:id]) if params[:id]
    @shop = Shop.find(params[:shop_id]) if params[:shop_id]
  end

  def set_area_node
    return unless params[:area_node_id]
    @area_node = AreaNode.find(params[:area_node_id])
  end

  def set_resource
    return unless params[:resource_id]
    @resource = Resource.find(params[:resource_id])
  end
end

