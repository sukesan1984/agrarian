class Entity::Item::ConsumeItemEntity < Entity::ItemEntity
  attr_reader
  def initialize(user_item, count, item)
    @user_item = user_item
    @count = count
    @item = item
  end
  
  def user_item_id
    return 0 unless @user_item
    return @user_item.id
  end

  def item_id
    return @item.id
  end

  def count
    return @count
  end

  def current_count
    return @count unless @user_item
    return @user_item.count
  end

  def give
    @user_item.count += @count
    return true
  end

  def throw
    after_count = @user_item.count - 1
    fail 'after count must be >= 0' if after_count < 0
    @user_item.count = after_count
    return true
  end

  def save!
    @user_item.save!
  end

  def name
    return @item.name
  end

  def result
    return 'ゲットしたで'
  end
end

