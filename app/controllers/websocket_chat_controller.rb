class WebsocketChatController < WebsocketRails::BaseController 
  def message_receive 
　　# クライアントからのメッセージを取得
　　# websocket_chatイベントで接続しているクライアントにブロードキャスト

　　receive_message = message()

　　broadcast_message(:websocket_chat, receive_message)
  end

  def message_receive2
    broadcast_message(:websocket_chat, message())
  end

  def connect
    Rails.logger.debug('connected')
    broadcast_message(:websocket_chat, 'hoge')
  end
end
