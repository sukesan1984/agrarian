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
end
