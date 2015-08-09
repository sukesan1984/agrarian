class Entity::Item::QuestItemEntity
  def initialize(user_quest)
    @user_quest = user_quest
  end

  def give
    return false unless @user_quest.can_receive

    @user_quest.set_status_to_received
  end

  def save!
    @user_quest.save!
  end

  def name
    return @user_quest.quest.name
  end

  def give_failed_message
    return 'すでにそのクエストを受注してるか、報酬を受け取ってないよ'
  end

  def result
    return 'のクエストを受注したよ'
  end
end

