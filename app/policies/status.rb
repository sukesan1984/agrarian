class Status
  attr_reader :attack, :defense, :critical_hit_chance, :critical_hit_damage, :dodge_chance, :damage_reduction,
    :damage_perc, :attack_rating_perc, :defense_perc, :hp, :hp_steal_perc

  def initialize(
    attack,
    defense,
    critical_hit_chance,
    critical_hit_damage,
    dodge_chance,
    damage_reduction,
    damage_perc,
    attack_rating_perc,
    defense_perc,
    hp,
    hp_steal_perc)

    @attack = attack
    @defense = defense

    @critical_hit_chance = critical_hit_chance
    @critical_hit_damage = critical_hit_damage

    @dodge_chance = dodge_chance
    @damage_reduction = damage_reduction

    @damage_perc = damage_perc
    @attack_rating_perc = attack_rating_perc
    @defense_perc = defense_perc
    @hp = hp
    @hp_steal_perc = hp_steal_perc
  end

  # 説明文をリストで返す
  def descriptions
    description_list = []
    if @attack != 0
      description_list.push("攻撃力: " + @attack.to_s)
    end

    if @defense != 0
      description_list.push("防御力: " + @defense.to_s)
    end

    if @critical_hit_chance != 0
      description_list.push("クリティカル発動率: " + @critical_hit_chance.to_s + "%")
    end

    if @critical_hit_damage != 0
      description_list.push("クリティカルダメージ: " + @critical_hit_damage.to_s)
    end

    if @dodge_chance != 0
      description_list.push("回避率: " + @dodge_chance.to_s + "%")
    end

    if @damage_reduction != 0
      description_list.push("被ダメージ減少率: " + @damage_reduction.to_s + "%")
    end

    if @damage_perc != 0
      description_list.push("ダメージ上昇率: +" + @damage_perc.to_s + "%")
    end

    if @attack_rating_perc != 0
      description_list.push("命中率: +" + @attack_rating_perc.to_s + "%")
    end

    if @defense_perc != 0
      description_list.push("防御力アップ率: +" + @defense_perc.to_s + "%")
    end

    if @hp != 0
      description_list.push("HP: +" + @hp.to_s)
    end

    if @hp_steal_perc != 0
      description_list.push("HP Steal: +" + @hp_steal_perc.to_s + "%")
    end

    return description_list
  end

  def +(other)
    new_attack = @attack + other.attack
    new_defense = @defense + other.defense
    new_critical_hit_chance = @critical_hit_chance + other.critical_hit_chance
    new_critical_hit_damage = @critical_hit_damage + other.critical_hit_damage
    new_dodge_chance = @dodge_chance + other.dodge_chance
    new_damage_reduction = @damage_reduction + other.damage_reduction
    new_damage_perc = @damage_perc + other.damage_perc
    new_attack_rating_perc = @attack_rating_perc + other.attack_rating_perc
    new_defense_perc = @defense_perc + other.defense_perc
    new_hp = @hp + other.hp
    new_hp_steal_perc = @hp_steal_perc + other.hp_steal_perc

    return Status.new(
      new_attack,
      new_defense,
      new_critical_hit_chance,
      new_critical_hit_damage,
      new_dodge_chance,
      new_damage_reduction,
      new_damage_perc,
      new_attack_rating_perc,
      new_defense_perc,
      new_hp,
      new_hp_steal_perc)
  end
end

