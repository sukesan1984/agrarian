class CharacterController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  # キャラクターの詳細ステータスを表示する。
  def status
    character_type = params[:character_type]
    character_id = params[:character_id]
    @character_service = @character_service_factory.build_by_character_type_and_character_id_and_player_id(character_type, character_id, @player_character.id)
  end

  def set_factories
    equipment_entity = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity)
    equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_entity_factory)
    soldier_character_factory = SoldierCharacterFactory.new(equipped_list_entity_factory)
    @character_service_factory = CharacterServiceFactory.new(@player_character_factory, soldier_character_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end
