# ResourceとActionのセットを扱うやつ
# リソースに対して何かするのはこいつ
class ResourceActionService
  def initialize(resource_service, action, user_item)
    @resource_service = resource_service
    @action           = action
    @user_item        = user_item
  end

  # 現在地の取得
  def current_count
    return @resource_service.current_count
  end

  # 実行
  # とりあえず汎用化後でするけど、一旦はharvestだけでok
  def execute()
    # トランザクション開始
    ActiveRecord::Base.transaction do
      # resourceを減らしてアイテムを増やす
      @resource_service.decrease(1)
      @resource_service.save!

      @user_item.count += 1
      @user_item.save!
    end
      return {
        message: @action.name,
        remain: @resource_service.current_count,
        success: true
      }
    rescue => e
      return {
        success: false
      }
  end
end
