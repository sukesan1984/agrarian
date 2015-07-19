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
end
