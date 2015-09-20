class WebsocketChatController < WebsocketRails::BaseController 
  before_filter :set_factories
  before_filter :set_player_character

  def message_receive
    broadcast_message(:websocket_chat, "[#{@name}] #{ message()}")
  end

  def connect
    Rails.logger.debug('connected')
    Redis.current.rpush('websocket-member', @name)
    broadcast_message(:websocket_chat, "#{@name}さんが入室しました。")
    broadcast_message(:websocket_member_in, @name)
  end

  def disconnect
    Rails.logger.debug('disconnected')
    Redis.current.lrem('websocket-member', 1, @name)
    broadcast_message(:websocket_chat, "#{@name}さんが退室しました。")
    broadcast_message(:websocket_member_out, @name)
  end

  def print_members
    length = Redis.current.llen('websocket-member')
    member_list = Redis.current.lrange('websocket-member', 0, length - 1)
    Rails.logger.debug(member_list)
  end

  def set_factories
    equipment_entity_factory      = EquipmentEntityFactory.new
    equipped_entity_factory       = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    @player_character_factory      = PlayerCharacterFactory.new(equipped_list_entity_factory)
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
