class AreaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @id = params[:id]
    area = Area.find_by(id: @id)

    if(area == nil)
      redirect_to("/areas/not_found")
      return
    end

    factory = AreaViewModelFactory.new()
    routes = Route.where("area_id = ?", @id)
    @target_routes = Array.new()
    routes.each do |route|
      @target_routes.push(factory.build_by_area_id(route.connected_area_id))
    end
  end

  def not_found
  end
end
