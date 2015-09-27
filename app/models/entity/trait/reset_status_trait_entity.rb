class Entity::Trait::ResetStatusTraitEntity
  def initialize(player)
    @player = player
  end

  def execute
    level = Level.get_level_from(@player.exp)
    points = level.level * 5
    puts '初期化 : ' << @player.name
    @player.update(str: 2, dex: 5, vit: 3, ene: 5, remaining_points: points)
  end
end
