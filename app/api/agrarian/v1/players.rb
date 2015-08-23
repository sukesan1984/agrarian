module Agrarian::V1
  class Players < Grape::API
    get '/players' do
      Player.all
    end

    get '/players/:id' do
      Player.all.find(params[:id])
    end

    get '/players/ranking/rails' do
      players = Player.all.sort_by(&:rails)
      ranking = []
      players.each.with_index(1) do |player, k|
        link = "http://agrarian/players/#{player[:id]}"
        ranking.push rank: k, id: player[:id], name: player[:name], rails: player[:rails], player: link
      end
      ranking
    end
  end
end

