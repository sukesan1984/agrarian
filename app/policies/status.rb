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

