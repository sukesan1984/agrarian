class NatureFieldController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def action
    @area_node_id = params[:id]

    area_service = AreaService.new
    area = area_service.build_by_area_node_id(@area_node_id)
    if(area.is_nil)
      redirect_to("/")
    end

    action_factory = ActionFactory.new
    action = action_factory.build_by_action_id(area.action.id)
    action.execute
  end
end
