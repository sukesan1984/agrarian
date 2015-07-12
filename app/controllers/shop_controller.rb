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
    shop_id = params[:id]
    area_node_id = params[:area_node_id]
    resource_id = params[:resource_id]

    # todo: validateクラスに寄せる
    area_node = AreaNode.find_by(id: area_node_id)
    shop = Shop.find_by(id: shop_id)
    resource = Resource.find_by(id: resource_id)

    if(area_node.nil? || resource.nil? || shop.nil?)
      redirect_to("/")
    end

    resource_service_factory = ResourceServiceFactory.new
    resource_service = resource_service_factory.build_by_target_id_and_resource(area_node_id, resource)
  end
end
