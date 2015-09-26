# == Schema Information
#
# Table name: chat_rooms
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChatRoom < ActiveRecord::Base
  include Redis::Objects
  list :player_ids

  def self.create_or_find(id)
    chat_room = ChatRoom.find_by(id: id)
    unless chat_room
      chat_room = ChatRoom.create(id: id)
    end
    return chat_room
  end
end
