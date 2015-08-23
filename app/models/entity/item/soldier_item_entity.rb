class Entity::Item::SoldierItemEntity
  attr_reader :item_id
  def initialize(player, soldier, item_id)
    @player  = player
    @soldier = soldier
    @gived_soldier = nil
    @item_id = item_id
  end

  # すでにそのSoldierを持っていたら、あげられない
  def give
    user_soldiers = UserSoldier.where(['player_id = ? and soldier_id = ?', @player.id, @soldier.id])
    return false if (user_soldiers.count >= 1)

    @gived_soldier = UserSoldier.new(
      player_id: @player.id,
      soldier_id: @soldier.id,
      current_hp: @soldier.hp_min
    )

    if UserSoldier.where(player_id: @player.id, is_in_party: 1).count < PartyAdditionService::MAX_PARTY_NUM
      @gived_soldier.is_in_party = 1
    end

    return true
  end

  def current_count
    return 1
  end 

  def give_failed_message
    return 'すでに仲間になってるよ'
  end

  def save!
    @gived_soldier.save!
  end

  def name
    return @soldier.name
  end

  def result
    return 'が仲間になったで'
  end
end

