class NatureFieldController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  # TODO: メソッドが長すぎるので分ける
  def action
    @area_node_id = params[:id]

    # player
    player_character_factory = PlayerCharacterFactory.new
    @player_character =
      player_character_factory.build_by_user_id(current_user.id)

    redirect_to '/player/input' if @player_character.nil?

    resource_service_action_factory =
      ResourceActionServiceFactory.new(@player_character.player)
    resource_service_fatory = ResourceServiceFactory.new
    area_service_factory =
      AreaServiceFactory.new(
        @player_character,
        resource_service_fatory,
        resource_service_action_factory
      )

    area = area_service_factory.build_by_area_node_id(@area_node_id)
    redirect_to '/' if area.is_nil

    if area.has_resource_action
      @result = area.resource_action_execute
      logger.debug(@result)
      redirect_to '/' if @result[:success] == false
    else
      redirect_to '/'
    end
  end
end

