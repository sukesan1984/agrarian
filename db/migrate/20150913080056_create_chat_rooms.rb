class CreateChatRooms < ActiveRecord::Migration
  def change
    create_table :chat_rooms do |t|

      t.timestamps null: false
    end
  end
end
