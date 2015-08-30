namespace :players do
  namespace :item do
    task add: :environment do
      ARGV.slice(1,ARGV.size).each{|v| task v.to_sym do; end}
      unless ARGV.length == 4
        puts '
          usage:
          $ bundle exec rake players:item:add [players_id] [item_id] [item_num]'
        exit 1
      end
      player_id = Integer(ARGV[1]) rescue nil
      item_id   = Integer(ARGV[2]) rescue nil
      item_num  = Integer(ARGV[3]) rescue nil

      item_entity_factory = create_item_entity_factory
      item_entity = item_entity_factory.build_by_player_id_and_item_id_and_count(player_id, item_id, item_num)

      puts("アイテム:#{item_entity.name}")
      puts("個数#{item_entity.count}")

      fail item_entity.give_failed_message unless item_entity.give
      item_entity.save!

      puts("付与成功!")
    end

    def create_item_entity_factory
      equipment_service_factory = EquipmentServiceFactory.new
      equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
      equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
      player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

      user_item_factory = UserItemFactory.new(equipped_list_service_factory)

      quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(user_item_factory)
      quest_entity_factory = Quest::QuestEntityFactory.new(player_character_factory, quest_condition_entity_factory)

      item_entity_factory = ItemEntityFactory.new(player_character_factory, user_item_factory, quest_entity_factory)

      return item_entity_factory
    end
  end
end
