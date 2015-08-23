module Agrarian::V1
  class Base < Grape::API
    version 'v1', using: :path
    format :json

    mount Users
    mount Players
  end
end
