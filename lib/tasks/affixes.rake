namespace :affix do
  task test: :environment do
    list = MagicAffixCreationService::get_affixes(100)
    list.each do |affix|
      puts affix.name
    end
  end
  task randomize: :environment do
    puts EquipmentAffix::get_random_value_by_min_and_max(10, 15)
  end

  task apply_magic: :environment do
    unless ARGV.length == 3 || ARGV.length == 1
      puts '
        Usage:
        $ bundle exec rake affix:apply_magic [player_id] [user_item_id] [item_rarity]
      '
    end

    data = get_player_id_and_user_item_id_and_rarity
    player_id = data[:player_id]
    user_item_id = data[:user_item_id]
    item_rarity = data[:item_rarity]

    equipment_entity_factory     = EquipmentEntityFactory.new
    equipped_entity_factory      = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_entity_factory = EquippedListEntityFactory.new(equipped_entity_factory)
    user_item_factory = UserItemFactory.new(equipped_list_entity_factory)

    user_item = user_item_factory.build_by_player_id_and_user_item_id(player_id, user_item_id)
    unless user_item
      puts 'player has not user_item_id' 
      exit 1
    end

    equipment_entity = equipment_entity_factory.build_by_user_item(user_item)

    MagicAffixCreationService::apply_magic(equipment_entity, item_rarity)

    puts equipment_entity.name
    puts equipment_entity.descriptions
  end

  def get_player_id_and_user_item_id_and_rarity
    if ARGV.length == 1
      print 'プレイヤーID : '
      player_id = STDIN.gets.chomp.gsub(' ', '').to_i
      print 'user_item_id : '
      user_item_id   = STDIN.gets.chomp.gsub(' ', '').to_i
      print 'レアリティ   : '
      item_rarity  = STDIN.gets.chomp.gsub(' ', '').to_i
    else
      player_id = Integer(ARGV[1]) rescue nil
      user_item_id   = Integer(ARGV[2]) rescue nil
      item_rarity  = Integer(ARGV[3]) rescue nil
    end
    return {player_id: player_id, user_item_id: user_item_id, item_rarity: item_rarity}
  end
end
