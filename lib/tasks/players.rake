namespace :players do
  namespace :item do
    task add: :environment do
      ARGV.slice(1,ARGV.size).each{|v| task v.to_sym do; end}
      unless ARGV.length == 4 || ARGV.length == 1
        puts '
          usage:
          $ bundle exec rake players:item:add [players_id] [item_id] [item_num]'
        exit 1
      end

      data = get_item_and_player_id
      player_id = data[:player_id]
      item_id   = data[:item_id]
      item_num  = data[:item_num]

      item_entity_factory = create_item_entity_factory
      item_entity = item_entity_factory.build_by_player_id_and_item_id_and_count(player_id, item_id, item_num)

      puts('プレイヤー   : ' << Player.find(player_id).name)
      puts('アイテム     : ' << item_entity.name)
      puts('個数         : ' << item_entity.count.to_s)

      fail item_entity.give_failed_message unless item_entity.give

      print '付与しますか？ y/n : '
      if STDIN.gets.chomp.gsub(' ', '') == 'y'
        item_entity.save!
        puts('付与成功!')
      else
        puts('キャンセルしました')
        exit 1
      end
    end

    def get_item_and_player_id
      if ARGV.length == 1
        print 'プレイヤーID : '
        player_id = STDIN.gets.chomp.gsub(' ', '').to_i
        print 'アイテムID   : '
        item_id   = STDIN.gets.chomp.gsub(' ', '').to_i
        print '個数         : '
        item_num  = STDIN.gets.chomp.gsub(' ', '').to_i
      else
        player_id = Integer(ARGV[1]) rescue nil
        item_id   = Integer(ARGV[2]) rescue nil
        item_num  = Integer(ARGV[3]) rescue nil
      end
      return {player_id: player_id, item_id: item_id, item_num: item_num}
    end

    def create_item_entity_factory
      equipment_entity_factory     = EquipmentEntityFactory.new
      equipped_entity_factory      = EquippedEntityFactory.new(equipment_entity_factory)
      equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
      player_character_factory      = PlayerCharacterFactory.new(equipped_list_entity_factory)

      user_item_factory = UserItemFactory.new(equipped_list_entity_factory)

      quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(user_item_factory)
      quest_entity_factory = Quest::QuestEntityFactory.new(player_character_factory, quest_condition_entity_factory)

      item_entity_factory = ItemEntityFactory.new(player_character_factory, user_item_factory, quest_entity_factory, equipment_entity_factory)

      return item_entity_factory
    end
  end
end
