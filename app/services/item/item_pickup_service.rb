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
      return { success: false, message: 'アイテム落ちてないよ' } unless @thrown_item.is_valid

      @thrown_item.decrease(1)
      @thrown_item.save!

      # user_itemに追加する。
      @user_item.increase(1)
      @user_item.save!
      return { success: true, message: @user_item.item.name + 'を拾った。今:' + @user_item.count.to_s + '個持ってる' }
    end
  rescue => e
    raise e
  end
end

