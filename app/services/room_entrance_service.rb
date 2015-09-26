# ルームの入り口のサービス
class RoomEntranceService
  def self.enter(area_node_id, player_id)
    chat_room = ChatRoom.create_or_find(area_node_id)
    if(chat_room.player_ids.include?(player_id))
      return
    end
    chat_room.player_ids.push(player_id)
    WebsocketRails[area_node_id].trigger(:area_room_member_in, player_id)
  end

  def self.exit(area_node_id, player_id)
    chat_room = ChatRoom.create_or_find(area_node_id)
    chat_room.player_ids.delete(player_id)
    WebsocketRails[area_node_id].trigger(:area_room_member_out, player_id)
  end
end
