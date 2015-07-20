class EquippedListServiceFactory
  def initialize(equipped_service_factory)
    @equipped_service_factory = equipped_service_factory
  end

  def build_by_player_id(player_id)
    user_equipment = UserEquipment.get_or_create(player_id)
    return EquippedListService.new(
      user_equipment: user_equipment,
      right_hand: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::RightHand, user_equipment.right_hand, player_id),
      left_hand: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::LeftHand, user_equipment.left_hand, player_id),
      both_hand: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::BothHand, user_equipment.both_hand, player_id),
      body: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::Body, user_equipment.body, player_id),
      head: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::Head, user_equipment.head, player_id),
      leg: @equipped_service_factory.build_by_part_and_user_item_id(BodyRegion::Type::Leg, user_equipment.leg, player_id))
  end
end

