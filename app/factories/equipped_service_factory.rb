class EquippedServiceFactory
  def initialize(equipment_service_factory)
    @equipment_service_factory = equipment_service_factory
  end

  def build_by_part_and_user_item_id(part, user_item_id)
    if user_item_id.nil?
      return EquippedService.new(part, nil)
    end

    user_item = UserItem.find_by(id: user_item_id)
    raise 'no user item: ' + user_item_id.to_s unless user_item

    return EquippedService.new(part, @equipment_service_factory.build_by_user_item(user_item))
  end

  # itemからパートを抽出してやる
  def build_by_user_item_id(user_item_id)
    user_item = UserItem.find_by(id: user_item_id)
    raise 'no user item: ' + user_item_id.to_s unless user_item

    equipment = Equipment.find_by(item_id: user_item.item_id)
    raise 'cant equip: ' + user_item.item_id unless equipment

    # TODO: refactor
    case(equipment.body_region)
    when 1
      return EquippedService.new(BodyRegion::Type::RightHand, @equipment_service_factory.build_by_user_item(user_item))
    when 2
      return EquippedService.new(BodyRegion::Type::Head, @equipment_service_factory.build_by_user_item(user_item))
    when 3
      return EquippedService.new(BodyRegion::Type::Body, @equipment_service_factory.build_by_user_item(user_item))
    when 4
      return EquippedService.new(BodyRegion::Type::Leg, @equipment_service_factory.build_by_user_item(user_item))
    end
  end
end
