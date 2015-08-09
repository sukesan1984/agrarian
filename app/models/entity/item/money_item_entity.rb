class Entity::Item::MoneyItemEntity
  def initialize(player, count)
    @player = player
    @count = count
  end

  def count
    return @count
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
