class InnController < ApplicationController
  before_action :authenticate_user!
  def index
    player_character_factory = PlayerCharacterFactory.new
    player_character = player_character_factory.build_by_user_id(current_user.id)
    if(player_character == nil)
      redirect_to("/player/input")
      return
    end

    player_character.recover_hp_all
    player_character.save
  end
end
