class EquippedEntityFactory
  def initialize(equipment_entity_factory)
    @equipment_entity_factory = equipment_entity_factory
  end

  def build_by_part_and_user_item_id(part, user_item_id, player_id)
    if user_item_id.nil? || user_item_id == 0
      return Entity::EquippedEntity.new(part, nil)
    end

    user_item = UserItem.find_by(id: user_item_id, player_id: player_id)
    fail 'no user item: ' + user_item_id.to_s unless user_item

    return Entity::EquippedEntity.new(part, @equipment_entity_factory.build_by_user_item(user_item))
  end

  # itemからパートを抽出してやる
  def build_by_user_item_id(user_item_id, player_id)
    # 他人のやつ装備できないようにしておく
    user_item = UserItem.find_by(id: user_item_id, player_id: player_id)
    fail 'no user item: ' + user_item_id.to_s unless user_item

    equipment = Equipment.find_by(item_id: user_item.item_id)
    fail 'cant equip: ' + user_item.item_id unless equipment

    # TODO: refactor
    case (equipment.body_region)
    when 1
      return Entity::EquippedEntity.new(BodyRegion::Type::RightHand, @equipment_entity_factory.build_by_user_item(user_item))
    when 2
      return Entity::EquippedEntity.new(BodyRegion::Type::LeftHand, @equipment_entity_factory.build_by_user_item(user_item))
    when 3
      return Entity::EquippedEntity.new(BodyRegion::Type::Head, @equipment_entity_factory.build_by_user_item(user_item))
    when 4
      return Entity::EquippedEntity.new(BodyRegion::Type::Body, @equipment_entity_factory.build_by_user_item(user_item))
    when 5
      return Entity::EquippedEntity.new(BodyRegion::Type::Leg, @equipment_entity_factory.build_by_user_item(user_item))
    end
  end
end

