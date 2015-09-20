class AreaRoomController < WebsocketRails::BaseController
  before_filter :set_factories
  before_filter :set_player_character
  before_filter :set_current_place

  def connect
    Rails.logger.debug("connected AreaRoome Controller")
  end

  def disconnect
    Rails.logger.debug("disconnected AreaRoome Controller")
    #RoomEntranceService.exit(@user_area.area_node_id, @player_character.name)
  end

  def enter
    Rails.logger.debug("enter")
  end

  def exit
    Rails.logger.debug("exit")
  end

  def set_factories
    equipment_entity_factory      = EquipmentEntityFactory.new
    equipped_entity_factory       = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    @player_character_factory      = PlayerCharacterFactory.new(equipped_list_entity_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
  end

  def set_current_place
    @user_area = UserArea.get_or_create(@player_character.id)
  end
end
