# ある人の装備全体
class EquippedListService
  attr_reader :right_hand, :left_hand, :both_hand, :head, :body, :leg
  def initialize(user_equipment:, right_hand:, left_hand:, both_hand:, head:, body:, leg:)
    Rails.logger.debug(right_hand)
    @user_equipment = user_equipment
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
    case (equipped_service.part_id)
    when BodyRegion::Type::RightHand.id
      @right_hand = equipped_service
      @user_equipment.right_hand = equipped_service.user_item_id
    when BodyRegion::Type::LeftHand.id
      @left_hand = equipped_service
      @user_equipment.left_hand = equipped_service.user_item_id
    when BodyRegion::Type::Body.id
      @body = equipped_service
      @user_equipment.body = equipped_service.user_item_id
    when BodyRegion::Type::Head.id
      @head = equipped_service
      @user_equipment.head = equipped_service.user_item_id
    when BodyRegion::Type::Leg.id
      @leg = equipped_service
      @user_equipment.leg = equipped_service.user_item_id
    end
  end

  def unequip(user_item_id)
    # TODO: あとでかえてもいいけど、まーええんちゃう

    if @user_equipment.right_hand.to_i == user_item_id.to_i
      @right_hand = EquippedService.new(BodyRegion::Type::RightHand, nil)
      @user_equipment.right_hand = 0
      return
    elsif @user_equipment.left_hand.to_i == user_item_id.to_i
      @left_hand = EquippedService.new(BodyRegion::Type::LeftHand, nil)
      @user_equipment.left_hand = 0
      return
    elsif @user_equipment.head.to_i == user_item_id.to_i
      @head = EquippedService.new(BodyRegion::Type::Head, nil)
      @user_equipment.head = 0
      return
    elsif @user_equipment.body.to_i == user_item_id.to_i
      @body = EquippedService.new(BodyRegion::Type::Body, nil)
      @user_equipment.body = 0
      return
    elsif @user_equipment.leg.to_i == user_item_id.to_i
      @leg = EquippedService.new(BodyRegion::Type::Leg, nil)
      @user_equipment.leg = 0
      return
    else
      fail 'no item equipped: ' + user_item_id.to_s
    end
  end

  def status
    return list.inject(Status.new(0, 0)) { |sum, equipment_service| sum + equipment_service.status }
  end

  def save
    @user_equipment.save
  end
end

