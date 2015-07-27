# クエストを達成するサービス
class Quest::QuestAchieveService
  def initialize(quest)
    @quest = quest
  end

  def achieve
    begin
      ActiveRecord::Base.transaction do
        if !@quest.set_cleared
          return false
        end

        @quest.save!
        return true
      end
    rescue => e
      fail e
    end
  end
end
