class WebsocketChatController < WebsocketRails::BaseController 
  #before_action :set_factories
  #before_action :set_player_character

  def message_receive
    set_factories
    set_player_character
    name = @player_character ? @player_character.name : '名無しさん'
    broadcast_message(:websocket_chat,"[#{name}] #{ message()}")
  end

  def connect
    Rails.logger.debug('connected')
  end

  def set_factories
    equipment_service_factory      = EquipmentServiceFactory.new
    equipped_service_factory       = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    @player_character_factory      = PlayerCharacterFactory.new(equipped_list_service_factory)
  end

  def set_player_character
    if current_user.nil?
      @player_character = nil
      return
    end
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
  end
end
