# アイテム投棄サービス
class Item::ItemThrowService
  # プレイヤーがアイテムをどこに捨てるのか
  def initialize(item_entity, thrown_item, equipped_list_entity)
    @item_entity = item_entity
    @thrown_item = thrown_item
    @equipped_list_entity = equipped_list_entity
  end

  # 実際に捨てる
  def throw
    if @item_entity.equipped?
      return { success: false, message: '装備してるやつは捨てられへんで' }
    end
    ActiveRecord::Base.transaction do
      # アイテムの削除
      @item_entity.throw
      @item_entity.save!

      # 捨てられたアイテムに登録
      # 有効期限内であればカウントを増やすけど、
      # 有効期限がすぎていればカウントを1に戻す
      if @thrown_item.is_valid
        @thrown_item.count += 1
      else
        @thrown_item.count = 1
      end

      @thrown_item.thrown_at = Time.now
      @thrown_item.save!
      return { success: true, message: @item_entity.name + 'を捨てた。今:' + @item_entity.current_count.to_s + '個持ってる' }
    end
  rescue => e
    raise e
  end
end

