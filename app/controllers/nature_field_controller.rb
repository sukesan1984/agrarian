class NatureFieldController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def action
    @area_id = params[:id]
  end
end
