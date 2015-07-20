class ItemController < ApplicationController
  before_action :authenticate_user!
  def index
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    # player
    @player_character = player_character_factory.build_by_user_id(current_user.id)

    if(@player_character == nil)
      redirect_to("/player/input")
    end

    @user_items = UserItem.where("player_id = ?", @player_character.player.id)
  end

  def use
    user_item_id = params[:user_item_id]
  end
end
