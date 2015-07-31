class Quest::QuestEntityFactory
  def initialize(player_character_factory, quest_condition_entity_factory)
    @player_character_factory = player_character_factory
    @quest_condition_entity_factory = quest_condition_entity_factory
  end

  def build_by_user_quest_and_player_id(user_quest, player_id)
    player = @player_character_factory.build_by_player_id(player_id)

    quest_id = user_quest.quest_id
    quest = Quest.find_by(id: quest_id)
    quest_conditions = QuestCondition.where(quest_id: quest_id)
    quest_condition_entities = []
    quest_conditions.each do |quest_condition|
      quest_condition_entities.push(@quest_condition_entity_factory.build_by_quest_condition(quest_condition, player))
    end
    return Quest::QuestEntity.new(quest, user_quest, quest_condition_entities)
  end
end

