class ShopController < ApplicationController
  def index
    id = params[:id]
    @shop = Shop.find_by(id: id)
  end
end
