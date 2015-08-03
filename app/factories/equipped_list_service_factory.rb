class EquippedListServiceFactory
  def initialize(equipped_service_factory)
    @equipped_service_factory = equipped_service_factory
  end

  def build_by_character_type_and_character_id_and_player_id(character_type, character_id, player_id)
    case(character_type.to_i)

    # player
    when 1
      return build_by_player_id(player_id)
    # soldier
    when 2
      return build_by_soldier_id_and_player_id(character_id, player_id)
    end
  end

  def build_by_soldier_id_and_player_id(soldier_id, player_id)
      user_soldier = UserSoldier.find_by(id: soldier_id, player_id: player_id)
      return build_by_equipment_and_player_id(user_soldier, player_id)
  end

  def build_by_player_id(player_id)
    user_equipment = UserEquipment.get_or_create(player_id)
    return build_by_equipment_and_player_id(user_equipment, player_id)
  end

  private 
  def build_by_equipment_and_player_id(equipment_model, player_id)
    return EquippedListService.new(
      equipment_model: equipment_model,
      right_hand: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::RightHand, equipment_model.right_hand, player_id),
      left_hand: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::LeftHand, equipment_model.left_hand, player_id),
      both_hand: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::BothHand, equipment_model.both_hand, player_id),
      body: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::Body, equipment_model.body, player_id),
      head: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::Head, equipment_model.head, player_id),
      leg: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::Leg, equipment_model.leg, player_id))
  end
end

