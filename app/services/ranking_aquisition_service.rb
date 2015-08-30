class RankingAquisitionService
  def initialize
  end

  # count: 必要な数
  def get_player_rails(count)
    return Player.order('rails DESC').limit(count)
  end

  def get_player_rails_all
    return Player.all.sort_by(&:rails).reverse
  end

  def get_user_bank_rails(count)
    return UserBank.order('rails DESC').limit(count)
  end
end

