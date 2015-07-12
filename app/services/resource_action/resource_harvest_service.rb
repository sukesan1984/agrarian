# ResourceとActionのセットを扱うやつ
# Resourceを収穫する
class ResourceAction::ResourceHarvestService
  def initialize(resource_service, harvest, user_item)
    @resource_service = resource_service
    @harvest          = harvest
    @user_item        = user_item
  end

  # 現在地の取得
  def current_count
    return @resource_service.current_count
  end

  def action_name
    return @harvest.name
  end

  # 実行
  # とりあえず汎用化後でするけど、一旦はharvestだけでok
  def execute()
    # トランザクション開始
    ActiveRecord::Base.transaction do
      # resourceを減らしてアイテムを増やす
      if(@resource_service.decrease(1).nil?)
        return {
          message: "無いよ！！",
          remain: @resource_service.current_count,
          success: true
        }
      end
      @resource_service.save!

      @user_item.count += 1
      @user_item.save!
    end
      return {
        message: @harvest.name,
        remain: @resource_service.current_count,
        success: true
      }
    rescue => e
      return {
        success: false
      }
  end
end
