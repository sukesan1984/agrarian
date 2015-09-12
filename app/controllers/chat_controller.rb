class ChatController < ApplicationController
  before_action :set_host

  def index
  end

  def set_host
    if Rails.env == 'production'
      @host = 'agrarian.jp:3001'
    else
      @host = 'localhost:3000'
    end
  end
end
