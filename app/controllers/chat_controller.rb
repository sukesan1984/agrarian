class ChatController < ApplicationController
  def index
    if Rails.env == 'production'
      @host = 'agrarian.jp:3001'
    else
      @host = 'localhost:3000'
    end
  end
end
