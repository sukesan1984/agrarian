# ある人の装備全体
class EquippedListService
  attr_reader :right_hand, :left_hand, :both_hand, :head, :body, :leg
  def initialize(equipment_model:, right_hand:, left_hand:, both_hand:, head:, body:, leg:)
    Rails.logger.debug(right_hand)
    @equipment_model = equipment_model
    @right_hand = right_hand
    @left_hand = left_hand
    @both_hand = both_hand
    @head = head
    @body = body
    @leg = leg
  end

  def list
    return [
      @head,
      @right_hand,
      @left_hand,
      @body,
      @leg
    ]
  end

  # equipped_service
  def exchange(equipped_service)
    equipped_service.set_equipped(true)
    case (equipped_service.part_id)
    when BodyRegion::Type::RightHand.id
      @right_hand.set_equipped(false)
      @right_hand = equipped_service
      @equipment_model.right_hand = equipped_service.user_item_id
    when BodyRegion::Type::LeftHand.id
      @left_hand.set_equipped(false)
      @left_hand = equipped_service
      @equipment_model.left_hand = equipped_service.user_item_id
    when BodyRegion::Type::Body.id
      @body.set_equipped(false)
      @body = equipped_service
      @equipment_model.body = equipped_service.user_item_id
    when BodyRegion::Type::Head.id
      @head.set_equipped(false)
      @head = equipped_service
      @equipment_model.head = equipped_service.user_item_id
    when BodyRegion::Type::Leg.id
      @leg.set_equipped(false)
      @leg = equipped_service
      @equipment_model.leg = equipped_service.user_item_id
    end
  end

  # 対象のuser_itemを装備しているか
  def equipped(user_item_id)
    return @equipment_model.right_hand.to_i == user_item_id.to_i ||
      @equipment_model.left_hand.to_i == user_item_id.to_i ||
      @equipment_model.head.to_i == user_item_id.to_i ||
      @equipment_model.body.to_i == user_item_id.to_i ||
      @equipment_model.leg.to_i == user_item_id.to_i
  end

  def unequip(user_item_id)
    # TODO: あとでかえてもいいけど、まーええんちゃう

    case(user_item_id.to_i)
    when @equipment_model.right_hand.to_i
      unequip_target_body_part(@right_hand, 'right_hand')
      return
    when @equipment_model.left_hand.to_i
      unequip_target_body_part(@right_hand, 'left_hand')
      return
    when @equipment_model.head.to_i
      unequip_target_body_part(@head, 'head')
      return
    when @equipment_model.body.to_i
      unequip_target_body_part(@body, 'body')
      return
    when @equipment_model.leg.to_i
      unequip_target_leg_part(@leg, 'leg')
      return
    end
    fail 'no item equipped: ' + user_item_id.to_s
  end

  def status
    return list.inject(Status.new(0, 0)) { |sum, equipment_service| sum + equipment_service.status }
  end

  def save!
    @equipment_model.save!
    self.list.each do |part|
      part.save!
    end
    if @modified
      @modified.save!
    end
  end

  private
  def unequip_target_body_part(body_part, part_name)
    body_part.set_equipped(false)
    @modified = body_part
    body_part = EquippedService.new(BodyRegion::Type::Leg, nil)
    @equipment_model.send("#{part_name}=", 0)
  end
end

