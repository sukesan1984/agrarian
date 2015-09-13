# ルームの入り口のサービス
class RoomEntranceService
  def self.enter(area_node_id, name)
    chat_room = ChatRoom.create_or_find(area_node_id)
    chat_room.user_ids.push(name)
    WebsocketRails[area_node_id].trigger(:area_room_member_in, name)
  end

  def self.exit(area_node_id, name)
    chat_room = ChatRoom.create_or_find(area_node_id)
    chat_room.user_ids.delete(name)
    WebsocketRails[area_node_id].trigger(:area_room_member_out, name)
  end
end
