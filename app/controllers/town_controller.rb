class TownController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def show 
    @id = params[:id]
    town = Town.find_by(id: @id)
    if(town == nil)
      redirect_to("/towns/not_found")
      return
    end
    @name = town.name
  end

  # 掲示板に書き込む
  def write
    player = Player.find_by(user_id:  current_user.id)

    if(player == nil)
      redirect_to("/player/input")
    end

    factory = AreaViewModelFactory.new()

    user_area = UserArea.get_or_create(player.id)
    town_view_model = factory.build_by_area_id(user_area.area_id)

    contents = params[:bbs][:contents]
    TownBulletinBoard.create(
      player_id: player.id,
      town_id: town_view_model.get_id,
      contents: contents,
    )
    redirect_to("/")
  end

  # 街が見つからない
  def not_found
  end
end
