class ResourceAction::ResourcePurchaseService
  def initialize(resource_service, user_item, player, showcase)
    @resource_service = resource_service
    @user_item = user_item
    @player    = player
    @showcase  = showcase
  end

  def current_count
  end

  def action_name
    return "購入する"
  end

  def execute()
    ActiveRecord::Base.transaction do
      if(@resource_service.decrease(1).nil?)
        return {
          message: "在庫あらへんわ・・ごめん",
          remain: @resource_service.current_count,
          success:true
        }
      end
      cost = @showcase.cost
      after_rails = @player.rails - cost
      if(after_rails < 0)
        return {
          message: "自分お金持ってへんやん。",
          remain: @resource_service.current_count,
          success:true
        }
      end

      @player.rails = after_rails

      @user_item.count += 1

      @player.save!
      @user_item.save!
      @resource_service.save!
    end
      return {
        message: @user_item.item.name + "ゲットしたで。",
        remain: @resource_service.current_count,
        success: true
      }
    rescue => e
      Rails.logger.debug(e)
      return {
        success: false
      }
  end
end
