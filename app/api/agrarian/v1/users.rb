module Agrarian::V1
  class Users < Grape::API
    get '/users' do
      User.all
    end
  end
end
