class Tasks::EnemyDropTest
  def self.execute
    player = Player.find_by(id: 4)

    item_lottery_component_factory = ItemLotteryComponentFactory.new

    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_entity_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)

    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    user_item_factory = UserItemFactory.new(equipped_list_service_factory)

    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(user_item_factory)
    quest_entity_factory = Quest::QuestEntityFactory.new(player_character_factory, quest_condition_entity_factory)

    item_entity_factory = ItemEntityFactory.new(player_character_factory, user_item_factory, quest_entity_factory)

    enemy_character_factory = EnemyCharacterFactory.new(item_lottery_component_factory, item_entity_factory)
    enemy = Enemy.find_by(id: 13)
    
    dropped = {}
    100.times do
      enemy_character = enemy_character_factory.build_by_enemy(player.id, enemy)
      if enemy_character.drop_item
        dropped[enemy_character.drop_item.name] = dropped[enemy_character.drop_item.name] ? dropped[enemy_character.drop_item.name] + 1 : 1
      else
        dropped[:nothing] = dropped[:nothing] ? dropped[:nothing] + 1 : 1
      end
    end

    puts(dropped)
  end
end
#Tasks::EnemyDropTest.execute
