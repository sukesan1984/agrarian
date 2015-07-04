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

  # 街が見つからない
  def not_found
  end
end
