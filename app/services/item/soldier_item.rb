class Item::SoldierItem
  def initialize(player, soldier)
    @player  = player
    @soldier = soldier
    @gived_soldier = nil
  end

  # すでにそのSoldierを持っていたら、あげられない
  def give
    user_soldiers = UserSoldier.where(["player_id = ? and soldier_id = ?", @player.id, @soldier.id])
    if(user_soldiers.count >= 1)
      return false
    end

    @gived_soldier = UserSoldier.new(
      player_id: @player.id,
      soldier_id: @soldier.id,
      current_hp: @soldier.hp
    )

    return true
  end

  def give_failed_message
    return "すでに仲間になってるよ"
  end

  def save!
    @gived_soldier.save!
  end

  def name
    return @soldier.name
  end

  def result
    return "が仲間になったで"
  end
end
