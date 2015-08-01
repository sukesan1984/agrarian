# アイテム拾得サービス
class Item::ItemPickupService
  def initialize(user_item, thrown_item)
    @user_item = user_item
    @thrown_item = thrown_item
  end

  # 拾う
  def pickup
    ActiveRecord::Base.transaction do
      # thrown_itemから減らす
      if !@thrown_item.is_valid
        return {success: false, message: 'アイテム落ちてないよ'}
      end

      @thrown_item.decrease(1)
      @thrown_item.save!

      # user_itemに追加する。
      @user_item.increase(1)
      @user_item.save!
    end
  rescue => e
    raise e
  end
end

