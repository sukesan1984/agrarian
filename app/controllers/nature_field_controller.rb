class NatureFieldController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def action
    @area_node_id = params[:id]

    # player
    player_character_factory = PlayerCharacterFactory.new
    @player_character = player_character_factory.build_by_user_id(current_user.id)

    if(@player_character == nil)
      redirect_to("/player/input")
    end

    resource_service_action_factory = ResourceActionServiceFactory.new(@player_character.player)
    resource_service_fatory = ResourceServiceFactory.new
    area_service_factory = AreaServiceFactory.new(@player_character, resource_service_fatory, resource_service_action_factory)

    area = area_service_factory.build_by_area_node_id(@area_node_id)
    if(area.is_nil)
      redirect_to("/")
    end

    if(area.has_resource_action)
      @result = area.resource_action_execute
      logger.debug(@result)
      if(@result[:success] == false)
        redirect_to("/")
      end
    else
      redirect_to("/")
    end
  end
end
