# アイテム投棄サービス
class Item::ItemThrowService
  # プレイヤーがアイテムをどこに捨てるのか
  def initialize(user_item, thrown_item, equipped_list_service)
    @user_item = user_item
    @thrown_item = thrown_item
    @equipped_list_service = equipped_list_service
  end

  # 実際に捨てる
  def throw
    if @equipped_list_service.equipped(@user_item.id)
      return {success: false, message: '装備してるやつは捨てられへんで'}
    end
    ActiveRecord::Base.transaction do
      # アイテムの削除
      after_count = @user_item.count - 1
      if(after_count <= 0)
        @user_item.destroy!
      else
        @user_item.count = after_count
        @user_item.save!
      end

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
      return {success: true, message: '捨てた'}
    end
    rescue => e 
      raise e
  end
end

