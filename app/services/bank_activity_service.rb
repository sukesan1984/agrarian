class BankActivityService
  def initialize(player, user_bank)
    @player = player
    @user_bank = user_bank
  end

  # valueだけ入金する
  def deposit(value)
    return false unless value.is_a?(Integer)
    return false if value < 0
    ActiveRecord::Base.transaction do
      return false unless @player.has_enough_rails?(value)
      Rails.logger.debug("hogehoge")
      @player.decrease_rails(value)
      @user_bank.add_rails(value)
      @player.save!
      @user_bank.save!
      return true
    end
  rescue => e
    raise e
  end

  # valueだけ出金する
  def draw(value)
    return false unless value.is_a?(Integer)
    return false if value < 0
    ActiveRecord::Base.transaction do
      return false unless @user_bank.has_enough_rails?(value)

      @player.give_rails(value)
      @user_bank.add_rails(-value)
      @player.save!
      @user_bank.save!
    end
  rescue => e
    raise e
  end
end
