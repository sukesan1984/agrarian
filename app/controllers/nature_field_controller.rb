class NatureFieldController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
  end

  # TODO: メソッドが長すぎるので分ける
  def action
    @area_node_id = params[:id]

    area = @area_service_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)
    redirect_to '/' if area.is_nil

    if area.has_resource_action
      @result = area.resource_action_execute
      logger.debug(@result)
      redirect_to '/' if @result[:success] == false
    else
      redirect_to '/'
    end
  end

  def set_factories
    # factory
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
    resource_service_action_factory =
      ResourceActionServiceFactory.new(@player_character_factory)
    resource_service_fatory = ResourceServiceFactory.new
    @area_service_factory =
      AreaServiceFactory.new(
        @player_character_factory,
        resource_service_fatory,
        resource_service_action_factory,
        Battle::BattleEncounterFactory.new(@player_character_factory)
      )
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end

