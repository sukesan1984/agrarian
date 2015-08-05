class QuestController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
    # quest_factory
    @user_quests = UserQuest.where(player_id: @player_character.id).select { |user_quest| !user_quest.is_not_received }
    @quest_entities = []
    @user_quests.each do |user_quest|
      quest_entity = @quest_entity_factory.build_by_user_quest_and_player_id(user_quest, @player_character.id)
      @quest_entities.push(quest_entity)
      Quest::QuestAchieveService.new(quest_entity).achieve
    end
  end

  def claim
    user_quest_id = params[:user_quest_id]

    # 報酬付与のためのitem_serviceのfactory
    item_service_factory = ItemServiceFactory.new(@player_character, UserItemFactory.new(@player_character))

    user_quest = UserQuest.find_by(id: user_quest_id, player_id: @player_character.id)
    fail 'user_quest is not found: ' + id.to_s if user_quest.nil?

    quest_entity = @quest_entity_factory.build_by_user_quest_and_player_id(user_quest, @player_character.id)
    @item_service = item_service_factory.build_by_gift_id(quest_entity.gift_id)

    Quest::QuestClaimService.new(quest_entity, @item_service).claim
  end

  private
  def set_factories
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
    @quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new
    @quest_entity_factory = Quest::QuestEntityFactory.new(@player_character_factory, @quest_condition_entity_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end

