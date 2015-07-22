class InnController < ApplicationController
  before_action :authenticate_user!
  def index
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    # player
    player_character = player_character_factory.build_by_user_id(current_user.id)
    if player_character.nil?
      redirect_to('/player/input')
      return
    end

    player_character.recover_hp_all
    player_character.save

    user_soldiers = UserSoldier.where(player_id: player_character.id)
    user_soldiers.each do |user_soldier|
      soldier_character = SoldierCharacter.new(user_soldier)
      soldier_character.recover_hp_all
      soldier_character.save
    end
  end
end

