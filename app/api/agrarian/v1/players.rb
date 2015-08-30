module Agrarian::V1
  class Players < Grape::API
    resource :players do
      get '' do
        Player.all
      end

      get ':id' do
        Player.all.find(params[:id])
      end

      get 'ranking/rails' do
        players = RankingAquisitionService.new.get_player_rails_all
        ranking = []
        players.each.with_index(1) do |player, k|
          link = "http://agrarian.jp/api/v1/players/#{player[:id]}"
          ranking.push rank: k, id: player[:id], name: player[:name], rails: player[:rails], player: link
        end
        ranking
      end
    end
  end
end

