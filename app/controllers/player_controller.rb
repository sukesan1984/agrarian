class PlayerController < ApplicationController
  before_action :authenticate_user!
  def index
    @name="hoge"
  end

  def input
    @players = Player.where("user_id = ?", current_user.id)
    if(@players.count != 0)
      redirect_to("/")
    end
  end

  def create
    name = params[:player][:name]

    @players = Player.where("user_id = ?", current_user.id)

    #新規の時だけ作成する。
    if(@players.count == 0)
      @player = Player.create(name: name, user_id: current_user.id)
    else
      @player = @players[0]
    end
  end
end
