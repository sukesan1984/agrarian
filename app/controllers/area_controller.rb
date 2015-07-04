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

    factory = AreaViewModelFactory.new()
    area_view_model = factory.build(@area_type, @type_id)
    path = area_view_model.get_redirect_to()
    if(path != nil)
      redirect_to(path)
    end
  end

  def not_found
  end
end
