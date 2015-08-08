# レベルからステータスを計算してくれるサービス
class StatusCalculationUtility
  def self.calculate(status_min, status_max, level_max, level_current)
    delta = ((status_max - status_min) / (level_max - 1)).to_i
    return status_min + delta * (level_current - 1)
  end
end
