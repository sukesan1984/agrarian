class Battle::BattleEncounterFactory
  def initialize(player_character_factory)
    @player_character_factory = player_character_factory
  end

  def build_by_area_id_and_player_id(area_id, player_id)
    area = Area.find_by(id: area_id)
    fail 'no area ' + area_id.to_s unless area

    player = @player_character_factory.build_by_player_id(player_id)

    enemy_maps = EnemyMap.where(area_id: area.id)
    enemies_lottery = Battle::EnemiesLottery.new(enemy_maps)

    return Battle::Encounter.new(player, area, enemy_maps, enemies_lottery)
  end
end
