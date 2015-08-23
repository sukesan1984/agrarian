class Entity::Item::ConsumeItemEntity
  attr_reader :item_id
  def initialize(user_item, count, item_id)
    @user_item = user_item
    @count = count
    @item_id = item_id
  end

  def item_id
    return @user_item.item.id
  end

  def count
    return @count
  end

  def current_count
    return @user_item.count
  end

  def give
    @user_item.count += @count
    return true
  end

  def save!
    @user_item.save!
  end

  def name
    return @user_item.item.name
  end

  def result
    return 'ゲットしたで'
  end
end

