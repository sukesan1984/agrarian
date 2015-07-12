class NatureFieldController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def action
    @area_node_id = params[:id]

    resource_service_fatory = ResourceServiceFactory.new
    area_service_factory = AreaServiceFactory.new(resource_service_fatory)

    area = area_service_factory.build_by_area_node_id(@area_node_id)
    if(area.is_nil)
      redirect_to("/")
    end

    if(area.has_resource_action)
      @result = area.resource_action_execute
    else
      redirect_to("/")
    end
  end
end
