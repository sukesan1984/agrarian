class TraitFactory
  def initialize(player_character_factory, soldier_character_factory)
    @soldier_character_factory = soldier_character_factory
    @player_character_factory = player_character_factory
  end

  def build_by_comsumption_and_player_id(consumption, player_id)
    player = @player_character_factory.build_by_player_id(player_id)
    case consumption.consumption_type
    when 1
      # HP回復するターゲットを取得する。
      targets = []
      soldier_characters = @soldier_character_factory.build_by_player_id(player.id)
      targets.concat(soldier_characters)
      targets.push(player)
      return Entity::Trait::RecoverHpTraitEntity.new(targets, consumption.type_value)
    when 2
      # 移動先のターゲットを取得する。
      # TODO: エンモルドがマップに登場したら、変更する。
      targets = Town.where('id not in (?)', [3,5,6,7])
      user_area = UserArea.get_or_create(player.id)
      fail 'no user area' unless user_area
      return Entity::Trait::MoveTraitEntity.new(user_area, targets)
    when 3
      return Entity::Trait::ResetStatusTraitEntity.new(player)
    end
  end
end

