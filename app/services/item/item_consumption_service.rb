class Item::ItemConsumptionService
  # 性質を持ってる
  def initialize(user_item, trait)
    @user_item = user_item
    @trait = trait
  end

  # itemを消費して効果を発揮する。
  def use(target_type, target_id)
    ActiveRecord::Base.transaction do
      # アイテムの消費
      if @user_item.count <= 0
        return { success: false, message: '使用できるアイテムを持っていません。' }
      end

      @user_item.count -= 1
      result = @trait.execute(target_type, target_id)
      return { success: false, message: @trait.failed_message } unless result

      @user_item.save!
      @trait.save!

      return { success: true, message: @trait.success_message }
    end
  rescue => e
    Rails.logger.debug(e)
    return { success: false, message: '失敗しました。' }
  end

  def name
    return @user_item.item.name
  end

  def user_item_id
    return @user_item.id
  end

  def targets
    return @trait.targets
  end
end

