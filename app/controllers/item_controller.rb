class ItemController < ApplicationController
  before_action :authenticate_user!
  def index
    # player
    player_character_factory = PlayerCharacterFactory.new
    @player_character = player_character_factory.build_by_user_id(current_user.id)

    if(@player_character == nil)
      redirect_to("/player/input")
    end

    @user_items = UserItem.where("player_id = ?", @player_character.player.id)
  end
end
