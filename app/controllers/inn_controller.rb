class InnController < ApplicationController
  before_action :authenticate_user!
  def index
    id = params[:id]
    @inn = Inn.find_by(id: id)
  end

  def sleep
    id = params[:id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
    soldier_character_factory = SoldierCharacterFactory.new(equipped_list_service_factory)

    # player
    player_character = player_character_factory.build_by_user_id(current_user.id)
    if player_character.nil?
      redirect_to('/player/input')
      return
    end

    # 宿屋
    @inn = Inn.find_by(id: id)
    fail 'no inn' + id.to_s if @inn.nil?

    soldiers = soldier_character_factory.build_by_player_id(player_character.id)

    inn_service = InnService.new(@inn, player_character, soldiers)
    inn_service.sleep
  end
end

