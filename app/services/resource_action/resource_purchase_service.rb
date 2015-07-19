class ResourceAction::ResourcePurchaseService
  def initialize(resource_service, item_service, player, showcase)
    @resource_service = resource_service
    @item_service = item_service
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
      if(@resource_service.decrease(1).nil?)
        return {
          message: "在庫あらへんわ・・ごめん",
          remain: @resource_service.current_count,
          success:true
        }
      end

      if(!@item_service.give)
        return {
          message: @item_service.give_failed_message,
          remain: @resource_service.current_count,
          success:true
        }
      end

      @player.save!
      @item_service.save!
      @resource_service.save!
    end
      return {
        message: @item_service.name + @item_service.result,
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
