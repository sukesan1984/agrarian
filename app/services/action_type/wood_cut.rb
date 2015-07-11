class ActionType::WoodCut < ActionType::Base
  def initialize(action)
    @action = action
  end
  # 実行
  def execute
    Rails.logger.debug("木を切った:")
  end
end
