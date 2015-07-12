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
        cost: showcase.cost
      })
    end
  end

  # 購入する
  def buy
    shop_id = params[:id]
    resource_id = params[:resource_id]


  end
end
