# クエストを達成するサービス
class Quest::QuestAchieveService
  def initialize(quest)
    @quest = quest
  end

  def achieve
    ActiveRecord::Base.transaction do
      return false unless @quest.set_cleared

      @quest.save!
      return true
    end
  rescue => e
    raise e
  end
end

