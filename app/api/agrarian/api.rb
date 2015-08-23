module Agrarian
  require 'v1/base'
  class API < Grape::API
    mount V1::Base
  end
end

