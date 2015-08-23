class Entity::Item::MoneyItemEntity
  attr_reader :item_id
  def initialize(player, count, item_id)
    @player = player
    @count = count
    @item_id = item_id
  end

  def count
    return @count
  end

  def current_count
    return @player.rails
  end

  def give
    @player.give_rails(@count)
    return true
  end

  def save!
    @player.save!
  end

  def name
    return 'rails'
  end

  def result
    return 'ゲットしたで'
  end
end

