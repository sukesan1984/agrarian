# クエストのEntityモデル
# 基本的にはUserQuestに紐づく。
# aggregate
class Quest::QuestEntity
  def initialize(quest, user_quest, quest_condition_entities)
    @quest = quest
    @user_quest = user_quest
    @quest_condition_entities = quest_condition_entities
  end

  # いまだクリアになっていない物
  def is_not_cleared
    return @user_quest.is_received
  end

  def gift_id
    return @quest.reward_gift_id
  end

  # クリア済みかいなかを返す。
  # 計算してキャッシュするために、状態更新する
  def set_cleared
    # すでにクリア済みのときは再計算しない。
    if @user_quest.is_cleared
      return true
    end

    # 未クリア時はチェックする
    @quest_condition_entities.each do |quest_condition_entity| 
      # 一つでもクリアしていない物があれば、未クリア
      if !quest_condition_entity.is_cleared
        return false
      end
    end

    @user_quest.set_cleared
    return true
  end

  # 報酬受け取り状態にする。
  def set_claimed
    @quest_condition_entities.each do |quest_condition_entity|
      quest_condition_entity.set_claimed
    end

    return @user_quest.set_claimed
  end

  def save!
    @user_quest.save!
    @quest_condition_entities.each do |quest_condition_entity|
      quest_condition_entity.save!
    end
  end
end

