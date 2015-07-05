class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @players = Player.where("user_id = ?", current_user.id)
    if(@players.size == 0)
      redirect_to("/player/input")
    else
      @player = @players[0]

      #現在地に飛ばす。
      current_area_id = UserArea.get_current_or_create(@player.id)
      redirect_to("/areas/" + current_area_id.to_s())
    end
  end

  def show
  end
end
