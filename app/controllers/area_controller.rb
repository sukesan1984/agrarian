class AreaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @id = params[:id]

    resource_service_factory = ResourceServiceFactory.new
    factory = AreaServiceFactory.new(resource_service_factory)

    @current = factory.build_by_area_node_id(@id)

    if(@current.is_nil)
      redirect_to("/areas/not_found")
      return
    end

    # その位置でのターゲットを取得する。
    routes = Route.where("area_node_id = ?", @current.area_node.id)
    @target_routes = Array.new()
    routes.each do |route|
      @target_routes.push(factory.build_by_area_node_id(route.connected_area_node_id))
    end

    # nilじゃなかったら、each
    if(@current.next_to_area_node_id)
      @current.next_to_area_node_id.each do |area_node_id|
        @target_routes.push(factory.build_by_area_node_id(area_node_id))
      end
    end
    player_character_factory = PlayerCharacterFactory.new
    @player_character = player_character_factory.build_by_user_id(current_user.id)

    if(@player_character == nil)
      redirect_to("/player/input")
    end


    user_area = UserArea.get_or_create(@player_character.id)
    user_area.area_node_id = @id
    user_area.save()
  end

  def not_found
  end
end
