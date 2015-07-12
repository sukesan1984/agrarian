# ResourceとActionのセットを扱うやつ
# リソースに対して何かするのはこいつ
class ResourceActionService
  def initialize(resource_service, action)
    @resource_service = resource_service
    @action           = action
  end

  # 現在地の取得
  def current_count
    return @resource_service.current_count
  end

  # 実行
  # とりあえず汎用化後でするけど、一旦はharvestだけでok
  def execute()
    @resource_service.decrease(1)
    @resource_service.save!
    return {
      message: @action.name,
      remain: @resource_service.current_count
    }
  end
end
