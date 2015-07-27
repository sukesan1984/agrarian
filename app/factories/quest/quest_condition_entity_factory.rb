class Quest::QuestConditionEntityFactory
  def initialize
  end

  # quest_conditionのマスタを渡して生成する
  def build_by_quest_condition(quest_condition, player)
    case(quest_condition.condition_type)
    when ConditionType::KillEnemy
      return build_kill_enemy_condition_entity(quest_condition, player)
    end
  end

  private
  def build_kill_enemy_condition_entity(quest_condition, player)
    # 敵の討伐の進捗を取得
    user_progress = UserProgress.get_or_create(player.id, ProgressType::KillEnemy, quest_condition.condition_id)
    return Quest::Conditions::KillEnemyCondition.new(quest_condition, user_progress)
  end
end
