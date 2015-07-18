class SoldierCharacter
  def initialize(user_soldier)
    @user_soldier = user_soldier
    @soldier  = user_soldier.soldier
    @hp = StatusPoint.new(@user_soldier.current_hp, @soldier.hp)
  end

  def name
    return @soldier.name
  end

  def attack
    return @soldier.attack
  end

  def defense
    return @soldier.defense
  end

  def hp
    return @hp.current
  end

  def hp_max
    return @hp.max
  end

  def decrease_hp(value)
    @hp.decrease(value)
  end

  def recover_hp_all
    @hp.recover_all
  end

  def rails
    return 0
  end
  
  def save
    @user_soldier.current_hp = @hp.current
    if(@hp.current <= 0)
      @user_soldier.destroy
    else
      @user_soldier.save
    end
  end
end
