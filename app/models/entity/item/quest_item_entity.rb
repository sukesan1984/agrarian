class Entity::Item::QuestItemEntity < Entity::ItemEntity
  attr_reader :item_id
  def initialize(quest_entity, item_id)
    @quest_entity = quest_entity
    @item_id = item_id
  end

  def give
    return @quest_entity.set_received
  end

  def current_count
    return 1
  end

  def save!
    @quest_entity.save!
  end

  def name
    return @quest_entity.name
  end

  def count
    return 1
  end

  def give_failed_message
    return 'すでにそのクエストを受注してるか、報酬を受け取ってないよ'
  end

  def result
    return 'のクエストを受注したよ'
  end
end

