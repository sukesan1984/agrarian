namespace :status do
  task reset: :environment do
    print '全てのプレイヤーのステータスをリセットしますか？ y/n : '
    exit 1 if STDIN.gets.chomp.gsub(' ', '') == 'n'
    Player.all.each do |player|
      level = Level.get_level_from(player.exp)
      points = level.level * 5
      puts '初期化 : ' << player.name
      player.update(str: 2, dex: 5, vit: 3, ene: 5, remaining_points: points)
    end
  end
end

