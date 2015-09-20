class BankController < ApplicationController 
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
    @user_bank = UserBank.get_or_new(@player_character.id)
  end

  # 入金する
  def deposit
    rails = params[:bank][:rails].to_i
    @user_bank = UserBank.get_or_new(@player_character.id)
    if BankActivityService.new(@player_character, @user_bank).deposit(rails)
      @result = "#{rails} rails 預けた"
    else
      @result = '失敗した'
    end
  end

  # 出金する
  def draw
    rails = params[:bank][:rails].to_i
    @user_bank = UserBank.get_or_new(@player_character.id)
    if BankActivityService.new(@player_character, @user_bank).draw(rails)
      @result = "#{rails} rails 引き出した"
    else
      @result = '失敗した'
    end
  end

  def set_factories
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_entity_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end
