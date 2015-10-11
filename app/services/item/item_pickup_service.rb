# アイテム拾得サービス
class Item::ItemPickupService
  def initialize(item_entity, thrown_item, player_id)
    @item_entity = item_entity
    @thrown_item = thrown_item
    @player_id = player_id
  end

  # 拾う
  def pickup
    ActiveRecord::Base.transaction do
      # thrown_itemから減らす
      return { success: false, message: 'アイテム落ちてないよ' } unless @thrown_item.is_valid

      @thrown_item.destroy
      @thrown_item.save!

      @item_entity.give
      @item_entity.transfer(@player_id)
      @item_entity.save!
      return { success: true, message: @item_entity.name + 'を拾った。今:' + @item_entity.current_count.to_s + '個持ってる' }
    end
  rescue => e
    raise e
  end
end

