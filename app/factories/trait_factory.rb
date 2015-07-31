class TraitFactory
  def initialize(player_character_factory, soldier_character_factory)
    @soldier_character_factory = soldier_character_factory
    @player_character_factory = player_character_factory
  end

  def build_by_comsumption_and_player_id(consumption, player_id)
    player = @player_character_factory.build_by_player_id(player_id)
    case (consumption.consumption_type)
    when (1)
      # HP回復するターゲットを取得する。
      targets = []
      soldier_characters = @soldier_character_factory.build_by_player_id(player.id)
      targets.concat(soldier_characters)
      targets.push(player)
      return Trait::RecoverHpTrait.new(targets, consumption.type_value)
    end
  end
end

