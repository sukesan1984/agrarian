class QuestController < ApplicationController
  def index
    # なにはともあれ
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    if @player_character.nil?
      redirect_to '/player/input'
      return
    end

    # quest_factory
    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new
    quest_entity_factory = Quest::QuestEntityFactory.new(@player_character, quest_condition_entity_factory)
    @user_quests = UserQuest.where(player_id: @player_character.id).select{|user_quest| !user_quest.is_not_received}
    @quest_entities = []
    @user_quests.each do |user_quest|
      quest_entity = quest_entity_factory.build_by_user_quest(user_quest)
      @quest_entities.push(quest_entity)
      Quest::QuestAchieveService.new(quest_entity).achieve
    end
  end

  def claim
    user_quest_id = params[:user_quest_id]
    # なにはともあれ
    # factory
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)

    @player_character = player_character_factory.build_by_user_id(current_user.id)

    if @player_character.nil?
      redirect_to '/player/input'
      return
    end

    # quest_factory
    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new
    quest_entity_factory = Quest::QuestEntityFactory.new(@player_character, quest_condition_entity_factory)

    # 報酬付与のためのitem_serviceのfactory
    item_service_factory = ItemServiceFactory.new(@player_character)
    
    user_quest = UserQuest.find_by(id: user_quest_id, player_id: @player_character.id)
    if user_quest.nil?
      fail 'user_quest is not found: ' + id.to_s
    end

    quest_entity = quest_entity_factory.build_by_user_quest(user_quest)
    @item_service = item_service_factory.build_by_gift_id(quest_entity.gift_id)

    Quest::QuestClaimService.new(quest_entity, @item_service).claim
  end
end
