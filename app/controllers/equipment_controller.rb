class EquipmentController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  # 現在の装備
  # 装備可能アイテム一覧表示
  def index
    character_type = params[:character_type]
    character_id   = params[:character_id]

    @equipment_entitys = @equipment_entity_factory.build_list_by_player_id(@player_character.id)
    @equipped_list_service = @equipped_list_service_factory.build_by_character_type_and_character_id_and_player_id(character_type, character_id, @player_character.id)

    @character_service = @character_service_factory.build_by_character_type_and_character_id_and_player_id(character_type, character_id, @player_character.id)
  end

  # 装備を外す
  def unequip
    character_type = params[:character_type]
    character_id = params[:character_id]
    user_item_id = params[:user_item_id]

    # equipment_entity

    # equipped_list_service = @equipped_list_service_factory.build_by_player_id(@player_character.id)
    @equipped_list_service = @equipped_list_service_factory.build_by_character_type_and_character_id_and_player_id(character_type, character_id, @player_character.id)

    # 装備外すやつ
    @equipped_list_service.unequip(user_item_id)
    @equipped_list_service.save!

    redirect_to '/equipment/' + character_type.to_s + '/' + character_id.to_s
  end

  # 装備する
  def equip
    user_item_id = params[:user_item_id]
    character_id = params[:character_id]
    character_type = params[:character_type]

    user_item = UserItem.find_by(id: user_item_id, player_id: @player_character.id)
    if user_item.equipped == 1
      redirect_to '/equipment/' + character_type.to_s + '/' + character_id.to_s
      return
    end

    # equipment_entity
    @equipped_list_service = @equipped_list_service_factory.build_by_character_type_and_character_id_and_player_id(character_type, character_id, @player_character.id)

    # 交換するやつ
    ActiveRecord::Base.transaction do
      exchange_equipped_entity = @equipped_entity_factory.build_by_user_item_id(user_item_id, @player_character.id)
      @equipped_list_service.exchange(exchange_equipped_entity)
      exchange_equipped_entity.save!
      @equipped_list_service.save!
    end
    redirect_to '/equipment/' + character_type.to_s + '/' + character_id.to_s
  rescue => e
    raise e
  end

  def set_factories
    @equipment_entity_factory = EquipmentEntityFactory.new
    @equipped_entity_factory = EquippedEntityFactory.new(@equipment_entity_factory)
    @equipped_list_service_factory = EquippedListServiceFactory.new(@equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(@equipped_list_service_factory)
    @soldier_character_factory = SoldierCharacterFactory.new(@equipped_list_service_factory)
    @character_service_factory = CharacterServiceFactory.new(@player_character_factory, @soldier_character_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end

