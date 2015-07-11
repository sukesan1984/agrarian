class ActionFactory
  def initialize
  end

  def build_by_action_id(action_id)
    action = Action.find_by(id: action_id)
    if(action.nil?)
      return ActionType::Null.new
    end

    case action.id
    when 1
     return ActionType::WoodCut.new(action) 
    end
    return ActionType::Null.new
  end

end
