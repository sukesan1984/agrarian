class EquipmentController < ApplicationController
  before_action :authenticate_user!

  # 現在の装備
  # 装備可能アイテム一覧表示
  def index
    #なにはともあれ
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    unless @player_character
      redirect_to '/player/input'
      return
    end

    @equipment_services = equipment_service_factory.build_list_by_player_id(@player_character.id)

    # equipment_service

    @equipped_list_service = equipped_list_service_factory.build_by_player_id(@player_character.id)
  end

  # 装備を外す
  def unequip
    user_item_id = params[:user_item_id]

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    unless @player_character
      redirect_to '/player/input'
      return
    end

    # equipment_service

    equipped_list_service = equipped_list_service_factory.build_by_player_id(@player_character.id)

    # 装備外すやつ
    equipped_list_service.unequip(user_item_id)
    equipped_list_service.save

    redirect_to '/equipment'
  end

  # 装備する
  def equip
    user_item_id = params[:user_item_id]
    logger.debug(user_item_id)

    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    unless @player_character
      redirect_to '/player/input'
      return
    end

    # equipment_service
    equipped_list_service = equipped_list_service_factory.build_by_player_id(@player_character.id)

    # 交換するやつ
    exchange_equipped_service = equipped_service_factory.build_by_user_item_id(user_item_id, @player_character.id)
    equipped_list_service.exchange(exchange_equipped_service)
    equipped_list_service.save

    redirect_to '/equipment'
  end
end
