class AreaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
  end

  def show
    @area_node_id = params[:id].to_i

    @current = @area_service_factory.build_by_area_node_id_and_player_id(@area_node_id, @player_character.id)
    if @current.is_nil
      redirect_to '/areas/not_found'
      return
    end

    # 今の位置からその位置に移動できるかのチェック
    @current_target_routes = @area_service_factory.build_target_routes_by_player_id(@player_character.id)

    user_area = UserArea.get_or_create(@player_character.id)
    # 今いる位置からの移動できる場所 or 今いる位置
    can_move_list = @current_target_routes.map{ |target| target.area_node.id }
    can_move_list.push user_area.area_node_id
    unless can_move_list.include?(@area_node_id)
      redirect_to '/areas/cant_move'
      return
    end

    # その位置固有のアクションの実行
    @current.execute

    @can_move_to_next = @current.can_move_to_next

    @target_routes = @area_service_factory.build_target_routes_by_area_node_id_and_player_id(@current.area_node.id, @player_character.id)

    user_area.area_node_id = @area_node_id
    user_area.save

    # そのエリアに落ちてるアイテム
    @thrown_items = ThrownItem.where(area_node_id: @area_node_id)
                    .select{ |thrown_item| thrown_item.is_valid }
    @soldier_characters = @soldier_character_factory.build_party_by_player_id(@player_character.id)
  end

  def not_found
  end

  def cant_move
  end

  private
  def set_factories
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    @soldier_character_factory = SoldierCharacterFactory.new(equipped_list_service_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
    @resource_service_action_factory = ResourceActionServiceFactory.new(@player_character_factory)
    @resource_service_factory = ResourceServiceFactory.new
    @area_service_factory = AreaServiceFactory.new(@player_character_factory, @resource_service_factory, @resource_service_action_factory, Battle::BattleEncounterFactory.new(@player_character_factory))
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end

