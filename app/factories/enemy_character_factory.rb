class EnemyCharacterFactory
  def initialize(item_lottery_component_factory, item_entity_factory)
    @progress_cache = {}
    @item_lottery_component_factory = item_lottery_component_factory
    @item_entity_factory = item_entity_factory
  end

  def build_by_enemy_instance(player_id, enemy_instance)
    user_progress = get_user_progress_by_enemy_id(player_id, enemy_instance.enemy.id)
    drop_item_entity = get_drop_item_entity_by_enemy(player_id, enemy_instance.enemy)
    user_enemy_history = UserEnemyHistory.find_or_create(enemy_instance.id, player_id)
    return Entity::EnemyCharacterEntity.new(enemy_instance.enemy, user_progress, drop_item_entity, enemy_instance, user_enemy_history)
  end

  # enemyから生成する
  def build_by_enemy(player_id, enemy)
    user_progress = get_user_progress_by_enemy_id(player_id, enemy.id)
    drop_item_entity = get_drop_item_entity_by_enemy(player_id, enemy)
    return Entity::EnemyCharacterEntity.new(enemy, user_progress, drop_item_entity, enemy.hp, nil)
  end

  private
  def get_user_progress_by_enemy_id(player_id, enemy_id)
    if @progress_cache.key?(enemy_id)
      user_progress = @progress_cache[enemy_id]
    else
      user_progress = UserProgress.get_or_create(player_id, ProgressType::KillEnemy, enemy_id)
      # cache
      @progress_cache[enemy_id] = user_progress
    end
  end

  def get_drop_item_entity_by_enemy(player_id, enemy)
    item_lottery_component = @item_lottery_component_factory.build_by_group_id(enemy.item_lottery_group_id, nil)
    drop_item_entity = nil
    if item_lottery_component.nil?
      drop_item_entity = nil
    else
      drop_item = item_lottery_component.lot
      drop_item_entity = @item_entity_factory.build_by_player_id_and_item_id_and_count(player_id, drop_item.item_id, drop_item.count)
      # 装備品ならば、色付けも行う
      if drop_item_entity.equipment?
        EquipmentColoringService::make_equipment_colored(drop_item_entity, enemy.item_rarity)
      end
    end
    return drop_item_entity
  end
end

