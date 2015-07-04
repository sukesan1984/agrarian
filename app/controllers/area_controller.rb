class AreaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @id = params[:id]

    factory = AreaViewModelFactory.new()

    @current = factory.build_by_area_id(@id)

    if(@current.is_nil)
      redirect_to("/areas/not_found")
      return
    end

    routes = Route.where("area_id = ?", @id)
    @target_routes = Array.new()
    routes.each do |route|
      @target_routes.push(factory.build_by_area_id(route.connected_area_id))
    end

    player = Player.find_by(user_id:  current_user.id)
    if(player == nil)
      redirect_to("/player/input")
    end
    user_area = UserArea.get_or_create(player.id)
    user_area.area_id = @id
    user_area.save()
  end

  def not_found
  end
end
