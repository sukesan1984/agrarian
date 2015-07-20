class ItemConsumptionService
  # 性質を持ってる
  def initialize(user_item, trait)
    @user_item   = user_item
    @trait = trait
  end

  # itemを消費して効果を発揮する。
  def use
    begin
      ActiveRecord.transaction do
        # アイテムの消費
        if @user_item.count  <= 0
          return false
        end

        @user_item.count -= 1
        @trait.execute
        return true
      end
    rescue => e
      logger.debug(e)
    end
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
