class Battle::BattleEncounterFactory
  def initialize(player_character_factory, area_node_factory)
    @player_character_factory = player_character_factory
    @area_node_factory = area_node_factory
  end

  def build_by_area_node_id_and_player_id(area_node_id, player_id)
    area_node = @area_node_factory.get_by_area_node_id(area_node_id)

    player = @player_character_factory.build_by_player_id(player_id)

    enemy_maps = EnemyMap.where(area_id: area_node.area.id)
    enemies_lottery = Battle::EnemiesLottery.new(enemy_maps)

    user_encounter_enemy_group = UserEncounterEnemyGroup.find_by(player_id: player_id)
    if user_encounter_enemy_group.nil?
      user_encounter_enemy_group = UserEncounterEnemyGroup.new(
        player_id: player_id,
        enemy_group_id: 0)
    end

    return Battle::EncounteringEnemiesService.new(player, area_node, user_encounter_enemy_group, enemy_maps, enemies_lottery)
  end
end

