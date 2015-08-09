class Entity::Item::QuestItemEntity
  def initialize(quest_entity)
    @quest_entity = quest_entity
  end

  def give
    return @quest_entity.set_received
  end

  def save!
    @quest_entity.save!
  end

  def name
    return @quest_entity.name
  end

  def give_failed_message
    return 'すでにそのクエストを受注してるか、報酬を受け取ってないよ'
  end

  def result
    return 'のクエストを受注したよ'
  end
end

