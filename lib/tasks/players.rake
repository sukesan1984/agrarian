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
      user_item = UserItem.find_by(player_id: player_id, item_id: item_id)
      if user_item.nil?
        UserItem.create!(player_id: player_id, item_id: item_id, count: item_num)
      else
        num = user_item.count + item_num
        user_item.update(count: num)
      end
    end
  end
end
