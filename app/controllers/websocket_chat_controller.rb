class WebsocketChatController < WebsocketRails::BaseController 
  def message_receive 
    # クライアントからのメッセージを取得
    #
　　# websocket_chatイベントで接続しているクライアントにブロードキャスト
　　# #send_message(:websocket_chat, message()) 
    WebSocketRails[:websocket_with_channel].trigger(:websocket_chat, message)
  end
end
