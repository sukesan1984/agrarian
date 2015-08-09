class Quest::AbstractQuestConditionEntity
  def initialize(quest_condition)
    @quest_condition = quest_condition
  end

  def is_cleared
  end

  def set_claimed
  end

  def set_received
  end
end

