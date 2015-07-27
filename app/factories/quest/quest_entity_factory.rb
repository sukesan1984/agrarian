class Quest::QuestEntityFactory
  def initialize(player, quest_condition_entity_factory)
    @player = player
    @quest_condition_entity_factory = quest_condition_entity_factory
  end

  def build_by_user_quest(user_quest)
    quest_id = user_quest.quest_id
    quest = Quest.find_by(id: quest_id)
    quest_conditions = QuestCondition.where(quest_id: quest_id)
    quest_condition_entities = []
    quest_conditions.each do |quest_condition|
      quest_condition_entities.push( @quest_condition_entity_factory.build_by_quest_condition(quest_condition))
    end
    return Quest::QuestEntity.new(quest, user_quest, quest_condition_entities)
  end
end
