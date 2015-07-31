class NatureFieldController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  # TODO: メソッドが長すぎるので分ける
  def action
    @area_node_id = params[:id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    # player
    @player_character =
      player_character_factory.build_by_user_id(current_user.id)

    redirect_to '/player/input' if @player_character.nil?

    resource_service_action_factory =
      ResourceActionServiceFactory.new(player_character_factory)
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

