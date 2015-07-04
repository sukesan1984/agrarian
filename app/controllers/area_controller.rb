class AreaController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @id = params[:id]
    area = Area.find_by(id: @id)
    if(area == nil)
      redirect_to("/areas/not_found")
      return
    end
    @area_type = area.area_type
    @type_id   = area.type_id
  end

  def not_found
  end
end
