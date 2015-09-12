class WebsocketChatController < WebsocketRails::BaseController 
  def message_receive
    broadcast_message(:websocket_chat, message())
  end

  def connect
    Rails.logger.debug('connected')
    broadcast_message(:websocket_chat, 'hoge')
  end
end
