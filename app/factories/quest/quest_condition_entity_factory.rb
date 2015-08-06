class Quest::QuestConditionEntityFactory
  def initialize(user_item_factory)
    @user_item_factory = user_item_factory
  end

  # quest_conditionのマスタを渡して生成する
  def build_by_quest_condition(quest_condition, player)
    case (quest_condition.condition_type)
    when ConditionType::KillEnemy
      return build_kill_enemy_condition_entity(quest_condition, player)
    when ConditionType::CollectItem
      return build_collect_item_condition_entity(quest_condition, player)
    end 
  end

  private
  def build_kill_enemy_condition_entity(quest_condition, player)
    # 敵の討伐の進捗を取得
    user_progress = UserProgress.get_or_create(player.id, ProgressType::KillEnemy, quest_condition.condition_id)
    return Quest::Conditions::KillEnemyCondition.new(quest_condition, user_progress)
  end

  def build_collect_item_condition_entity(quest_condition, player)
    user_item  = @user_item_factory.build_by_player_id_and_item_id(player.id, quest_condition.condition_id)
    return Quest::Conditions::CollectItemCondition.new(quest_condition, user_item)
  end
end

