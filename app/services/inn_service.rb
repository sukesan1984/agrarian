# 宿屋サービス
class InnService
  def initialize(inn, player, soldiers)
    @inn = inn
    @player = player
    @soldiers = soldiers
  end

  # 休んだあと、お金を取る
  def sleep
    ActiveRecord::Base.transaction do
      unless @player.decrease_rails(@inn.rails)
        return { success: false, message: 'お金ないで' }
      end

      # プレイヤーのhp回復
      @player.recover_hp_all
      @player.save!

      # 傭兵のhp回復
      @soldiers.each do |soldier|
        soldier.recover_hp_all
        soldier.save!
      end
    end
  rescue => e
    raise e
  end
end

