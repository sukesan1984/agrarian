class TraitFactory
  def initialize(player, soldier_character_factory)
    @soldier_character_factory = soldier_character_factory
    @player = player
  end

  def build_by_comsumption(consumption)
    case(consumption.consumption_type)
    when(1)
      # HP回復するターゲットを取得する。
      targets = Array.new
      soldier_characters = @soldier_character_factory.build_by_player_id(@player.id)
      targets.concat(soldier_characters)
      targets.push(@player)
      return Trait::RecoverHpTrait.new(targets, consumption.type_value)
    end
  end
end
