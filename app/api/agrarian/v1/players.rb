module Agrarian::V1
  class Players < Grape::API

    get '/players' do
      Player.all
    end

    get '/players/:id' do
      Player.all.find(params[:id])
    end

    get '/players/ranking/rails' do
      players = Player.all.sort_by { |e| e.rails }
      ranking = []
      players.each.with_index(1) do |player, k|
        ranking.push rank: k, name: player[:name], rails: player[:rails]
      end
      ranking
    end
  end
end
