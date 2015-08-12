class SoldierController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
    @soldiers = @soldier_character_factory.build_by_player_id(@player_character.id)
  end

  # パーティから外す
  def remove
    user_soldier_id = params[:user_soldier_id]
  end

  # パーティに加える
  def add
    user_soldier_id = params[:user_soldier_id]
  end

  private 
  def set_factories
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    @soldier_character_factory = SoldierCharacterFactory.new(equipped_list_service_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end
