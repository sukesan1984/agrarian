# ある人の装備全体
class EquippedListService
  attr_reader :right_hand, :left_hand, :both_hand, :head, :body, :leg
  def initialize(user_equipment:, right_hand:, left_hand:, both_hand:, head:, body:, leg: )
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
      @leg,
    ]
  end

  # equipped_service
  def exchange(equipped_service)
    case(equipped_service.part_id)
    when BodyRegion::Type::RightHand.id
      @right_hand = equipped_service
      @user_equipment.right_hand = equipped_service.user_item_id
    when BodyRegion::Type::LeftHand.id
      @left_hand = equipped_service
      @user_equipment.left_hand = equipped_service.user_item_id
    when BodyRegion::Type::Body.id
      @body = equipped_service
      @user_equipment.body = equipped_service.user_item_id
    when HeadRegion::Type::Head.id
      @head = equipped_service
      @user_equipment.head = equipped_service.user_item_id
    when HeadRegion::Type::Leg.id
      @leg = equipped_service
      @user_equipment.leg = equipped_service.user_item_id
    end
  end

  def save
    @user_equipment.save
  end
end
