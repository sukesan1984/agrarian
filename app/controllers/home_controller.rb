class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @players = Player.where("user_id = ?", current_user.id)
    if(!@players.count == 0)
      redirect_to("/player/input")
    else
      @player = @players[0]
    end
  end

  def show
  end
end
