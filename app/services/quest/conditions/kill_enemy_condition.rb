class Quest::Conditions::KillEnemyCondition < Quest::AbstractQuestConditionEntity
  def initialize(quest_condition, progress)
    @quest_condition = quest_condition
    @progress = progress
  end

  # 特定の数の敵を倒したかどうか
  def is_cleared
    # ターゲットの数よりも進捗が大きければクリア
    return @quest_condition.condition_value <= @progress.count
  end

  # 報酬を付与したときに呼ばれる。
  # 主にリセット処理とか
  def set_claimed
    @progress.count = 0
  end

  def save!
    @progress.save!
  end
end
