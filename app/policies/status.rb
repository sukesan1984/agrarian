class Status
  attr_reader :attack, :defense, :critical_hit_chance, :critical_hit_damage, :dodge_chance, :damage_reduction
  def initialize(
    attack,
    defense,
    critical_hit_chance,
    critical_hit_damage,
    dodge_chance,
    damage_reduction)

    @attack = attack
    @defense = defense

    @critical_hit_chance = critical_hit_chance
    @critical_hit_damage = critical_hit_damage

    @dodge_chance = dodge_chance
    @damage_reduction = damage_reduction
  end

  def +(other)
    new_attack = @attack + other.attack
    new_defense = @defense + other.defense
    new_critical_hit_chance = @critical_hit_chance + other.critical_hit_chance
    new_critical_hit_damage = @critical_hit_damage + other.critical_hit_damage
    new_dodge_chance = @dodge_chance + other.dodge_chance
    new_damage_reduction = @damage_reduction + other.damage_reduction

    return Status.new(
      new_attack,
      new_defense,
      new_critical_hit_chance,
      new_critical_hit_damage,
      new_dodge_chance,
      new_damage_reduction)
  end
end

