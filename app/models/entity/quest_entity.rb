# クエストのEntityモデル
# 基本的にはUserQuestに紐づく。
# aggregate
class Entity::QuestEntity
  def initialize(quest, user_quest, quest_condition_entities)
    @quest = quest
    @user_quest = user_quest
    @quest_condition_entities = quest_condition_entities
  end

  def name
    return @quest.name
  end

  def status_name
    return @user_quest.status_name
  end

  def user_quest_id
    return @user_quest.id
  end

  def is_not_received_reward
    return @user_quest.is_not_received_reward
  end

  def progresses
    return @quest_condition_entities.map(&:progress)
  end

  # クエストを受けているやつ
  def is_received
    return @user_quest.is_received
  end

  def gift_id
    return @quest.reward_gift_id
  end

  def is_cleared
    @quest_condition_entities.each do |quest_condition_entity|
      # 一つでもクリアしていない物があれば、未クリア
      return false unless quest_condition_entity.is_cleared
    end

    return true
  end

  # 受注状態にする。
  def set_received
    @quest_condition_entities.each do |quest_condition_entity|
      # 一つでもクリアしていない物があれば、未クリア
      fail 'cant set_received' unless quest_condition_entity.set_received
    end

    return @user_quest.set_received
  end

  # clear状態にする。
  def set_cleared
    if is_cleared
      @user_quest.set_cleared
      return true
    end
    return false
  end

  # 報酬受け取り状態にする。
  def set_claimed
    @quest_condition_entities.each(&:set_claimed)
    return @user_quest.set_claimed
  end

  def save!
    @user_quest.save!
    @quest_condition_entities.each(&:save!)
  end
end

