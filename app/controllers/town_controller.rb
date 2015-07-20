class TownController < ApplicationController
  before_action :authenticate_user!
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
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    player_character = player_character_factory.build_by_user_id(current_user.id)

    redirect_to '/player/input' if player_character.nil?

    resource_service_action_factory =
      ResourceActionServiceFactory.new(player_character.player)
    resource_service_factory = ResourceServiceFactory.new
    factory = AreaServiceFactory.new(
      player_character,
      resource_service_factory,
      resource_service_action_factory
    )

    user_area = UserArea.get_or_create(player_character.id)
    town_view_model = factory.build_by_area_node_id(user_area.area_node.id)

    contents = params[:bbs][:contents]
    TownBulletinBoard.create(
      player_id: player_character.id,
      town_id: town_view_model.get_id,
      contents: contents
    )
    redirect_to '/'
  end

  # 街が見つからない
  def not_found
  end
end
