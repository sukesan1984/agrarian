class SoldierCharacter
  attr_reader :type
  def initialize(user_soldier, equipped_list_service)
    @type = 2
    @user_soldier = user_soldier
    @soldier  = user_soldier.soldier
    @equipped_list_service = equipped_list_service
    @hp = StatusPoint.new(@user_soldier.current_hp, @soldier.hp_min)
    @status = Status.new(@soldier.attack_min, @soldier.defense_min)
  end

  def id
    return @user_soldier.id
  end

  def name
    return @soldier.name
  end

  def attack
    return (@status + @equipped_list_service.status).attack
  end

  def defense
    return (@status + @equipped_list_service.status).defense
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

  def recover_hp(value)
    @hp += value
  end

  def save!
    @user_soldier.current_hp = @hp.current
    if (@hp.current <= 0)
      @equipped_list_service.unequip_all
      @equipped_list_service.save!
      @user_soldier.destroy
    else
      @user_soldier.save!
    end
  end
end

