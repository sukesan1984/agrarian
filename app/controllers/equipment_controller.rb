class EquipmentController < ApplicationController
  before_action :authenticate_user!

  # 装備可能アイテム一覧表示
  def index
    #なにはともあれ
    # player(TODO:refactor)
    player_character_factory = PlayerCharacterFactory.new
    @player_character = player_character_factory.build_by_user_id(current_user.id)

    unless @player_character
      redirect_to '/player/input'
      return
    end

    # equipment_service
    equipment_service_factory = EquipmentServiceFactory.new
    @equipment_services = equipment_service_factory.build_list_by_player_id(@player_character.id)
  end
end
