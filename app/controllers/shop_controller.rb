class ShopController < ApplicationController
  def index
    shop_id = params[:id]
    area_node_id = params[:area_node_id]

    @shop = Shop.find_by(id: shop_id)

    resource_service_factory = ResourceServiceFactory.new

    @showcases = Array.new
    @shop.showcases.each do |showcase|
      @showcases.push({
        resource_service: resource_service_factory.build_by_target_id_and_resource(area_node_id, showcase.resource),
        name: showcase.resource.item.name,
        cost: showcase.cost,
        area_node_id: area_node_id
      })
    end
  end

  # 購入する
  def buy
    shop_id = params[:shop_id]
    area_node_id = params[:area_node_id]
    resource_id = params[:resource_id]

    # todo: validateクラスに寄せる
    area_node = AreaNode.find_by(id: area_node_id)
    shop      = Shop.find_by(id: shop_id)
    resource  = Resource.find_by(id: resource_id)

    if(area_node.nil? || resource.nil? || shop.nil?)
      redirect_to("/")
      return
    end

    player_character_factory = PlayerCharacterFactory.new
    player_character = player_character_factory.build_by_user_id(current_user.id)

    if(player_character == nil)
      redirect_to("/player/input")
    end

    resource_service_factory = ResourceServiceFactory.new
    resource_service = resource_service_factory.build_by_target_id_and_resource(area_node_id, resource)

    item_service_factory = ItemServiceFactory.new(player_character)
    item_service = item_service_factory.build_by_item_id(resource_service.item.id)

    if(shop.nil?)
      logger.debug("shop is nil")
    end
    if(resource.nil?)
      logger.debug("resource is nil")
    end

    showcase = Showcase.find_by(shop_id: shop.id, resource_id: resource.id)


    resource_purchase_service = ResourceAction::ResourcePurchaseService.new(resource_service, item_service, player_character.player, showcase)

    @result = resource_purchase_service.execute()
    if(!@result[:success])
      redirect_to("/")
    end
  end
end
