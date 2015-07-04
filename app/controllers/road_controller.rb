class RoadController < ApplicationController
  before_action :authenticate_user!

  def index
  end
  def show
    @id = params[:id]
    road = Road.find_by(id: @id)
    if(road == nil)
      redirect_to("/roads/not_found")
      return
    end
    @name = road.name
  end

  #街道が見つからない。
  def not_found
  end
end
