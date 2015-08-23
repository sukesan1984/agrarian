module Agrarian::V1
  class Enemies < Grape::API
    resource :enemies do
      get '' do
        Enemy.all
      end

      get ':id' do
        Enemy.find(params[:id])
      end
    end
  end
end

