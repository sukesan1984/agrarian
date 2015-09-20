class TownController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
  end

  def show
    @id = params[:id]
    town = Town.find_by(id: @id)
    if town.nil?
      redirect_to '/towns/not_found'
      return
    end
    @name = town.name
  end

  # 掲示板に書き込む
  def write
    user_area = UserArea.get_or_create(@player_character.id)
    town_view_model = @area_service_factory.build_by_area_node_id_and_player_id(user_area.area_node.id, @player_character.id)

    contents = params[:bbs][:contents]
    TownBulletinBoard.create(
      player_id: @player_character.id,
      town_id: town_view_model.get_id,
      contents: contents
    )
    redirect_to '/'
  end

  # 街が見つからない
  def not_found
  end

  def set_factories
    # factory
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_entity_factory)
    resource_service_action_factory =
      ResourceActionServiceFactory.new(@player_character_factory)
    resource_service_factory = ResourceServiceFactory.new
    @area_service_factory = AreaServiceFactory.new(
      @player_character_factory,
      resource_service_factory,
      resource_service_action_factory,
      Battle::BattleEncounterFactory.new(@player_character_factory)
    )
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end

