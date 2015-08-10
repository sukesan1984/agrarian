class Quest::Conditions::CollectItemCondition <Quest::AbstractQuestConditionEntity
  def initialize(quest_condition, progress)
    @quest_condition = quest_condition
    @progress = progress
    Rails.logger.debug(@progress)
  end

  def progress
    return "#{@progress.count}/#{@quest_condition.condition_value}"
  end

  # 特定のアイテムを集めているかどうか
  def is_cleared
    return @quest_condition.condition_value <= @progress.count
  end

  def set_claimed
    if @quest_condition.condition_value > @progress.count
      fail 'cant claim'
    end

    @progress.count -= @quest_condition.condition_value
  end

  def set_received
    return true
  end

  def save!
    @progress.save!
  end
end
