class ActionType::Null < ActionType::Base
  def is_nil
    return true
  end
end
