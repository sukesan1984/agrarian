class PlayerController < ApplicationController
  before_action :authenticate_user!
  def index
    @name="hoge"
  end

  def input
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

  def authnticate_user!
    redirect_to "/usrs/sign_in"
  end
end
