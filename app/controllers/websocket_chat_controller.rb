class WebsocketChatController < WebsocketRails::BaseController 
  before_filter :set_factories
  before_filter :set_player_character

  def message_receive
    broadcast_message(:websocket_chat, "[#{@name}] #{ message()}")
  end

  def connect
    Rails.logger.debug('connected')
    broadcast_message(:websocket_chat, "#{@name}さんが入室しました。")
  end

  def disconnect
    Rails.logger.debug('disconnected')
    broadcast_message(:websocket_chat, "#{@name}さんが退室しました。")
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
      @name = '名無し'
      return
    end
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    @name = @player_character ? @player_character.name : '名無し'
  end
end
