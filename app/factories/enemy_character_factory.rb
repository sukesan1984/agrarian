class EnemyCharacterFactory
  def initialize(item_lottery_component_factory, item_entity_factory)
    @progress_cache = {}
    @item_lottery_component_factory = item_lottery_component_factory
    @item_entity_factory = item_entity_factory
  end

  # enemyから生成する
  def  build_by_enemy(player_id, enemy)
    if @progress_cache.key?(enemy.id)
      user_progress = @progress_cache[enemy.id]
    else
      user_progress = UserProgress.get_or_create(player_id, ProgressType::KillEnemy, enemy.id)
      # cache
      @progress_cache[enemy.id] = user_progress
    end

    item_lottery_component = @item_lottery_component_factory.build_by_group_id(enemy.item_lottery_group_id, nil)
    drop_item_entity = nil
    if item_lottery_component.nil?
      drop_item_entity = nil
    else
      drop_item = item_lottery_component.lot
      drop_item_entity = @item_entity_factory.build_by_player_id_and_item_id_and_count(player_id, drop_item.item_id, drop_item.count)
    end

    return Entity::EnemyCharacterEntity.new(enemy, user_progress, drop_item_entity)
  end
end

