class Entity::Item::ConsumeItemEntity 
  def initialize(user_item, count)
    @user_item = user_item
    @count = count
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

