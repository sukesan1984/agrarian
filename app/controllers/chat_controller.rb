class ChatController < ApplicationController
  before_action :set_host
  before_action :set_factories
  before_action :set_player_character

  def index
    length = Redis.current.llen('websocket-member')
    @member_list = Redis.current.lrange('websocket-member', 0, length - 1)
    return if @member_list.count == 0
    index = @member_list.index(@name)
    return unless index
    @member_list.delete_at(index)
    Rails.logger.debug(@member_list)
  end

  def set_host
    if Rails.env == 'production'
      @host = 'agrarian.jp:3001'
    else
      @host = 'localhost:3000'
    end
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
