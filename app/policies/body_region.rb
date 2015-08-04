class BodyRegion
  module Type
    RightHand = BodyPart.new(1, '右手', 'right_hand')
    LeftHand  = BodyPart.new(2, '左手', 'left_hand')
    BothHand  = BodyPart.new(3, '両手', 'both_hand')
    Head      = BodyPart.new(4, '頭', 'head')
    Body      = BodyPart.new(5, '体', 'body')
    Leg       = BodyPart.new(6, '足', 'leg')
  end

  def self.get_list
    return [Type::RightHand, Type::LeftHand, Type::Head, Type::Body, Type::Leg]
  end

  def self.get_by_variable_name(variable_name)
    case(variable_name)
    when 'right_hand'
      return Type::RightHand
    when 'left_hand'
      return Type::LeftHand
    when 'head'
      return Type::Head
    when 'body'
      return Type::Body
    when 'leg'
      return Type::Leg
    end
  end
end

