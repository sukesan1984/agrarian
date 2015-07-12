class ShopController < ApplicationController
  def index
    id = params[:id]
    area_node_id = params[:area_node_id]

    @shop = Shop.find_by(id: id)

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
end
