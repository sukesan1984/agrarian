class PlayerController < ApplicationController
  before_action :authenticate_user!
  def index
    @name = 'hoge'
  end

  def input
    @players = Player.where('user_id = ?', current_user.id)
    redirect_to '/' if @players.count != 0
  end

  def create
    name = params[:player][:name]

    @players = Player.where('user_id = ?', current_user.id)

    # 新規の時だけ作成する。
    if @players.count == 0
      @player = Player.create(name: name, user_id: current_user.id, hp_max: 30, hp: 30)
    else
      @player = @players[0]
    end
  end

  def list
    @players = Player.all
  end

  def ranking_rails
    @players = RankingAquisitionService.new.get_player_rails(5)
    @banks = RankingAquisitionService.new.get_user_bank_rails(5)
  end
end

