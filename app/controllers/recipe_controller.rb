class RecipeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
    item_entity_factory = ItemEntityFactory.new(@player_character, @user_item_factory, @quest_entity_factory)

    recipes = Recipe.all
    @recipe_list = []
    recipes.each do |recipe|
      required_items = []
      recipe.required_items.each do |required_item|
        required_items.push(item_entity_factory.build_by_item_id(required_item.item_id, required_item.count))
      end
      product = item_entity_factory.build_by_item_id(recipe.product_item.item_id, recipe.product_item.count)
      @recipe_list.push({id: recipe.id, required_items: required_items, product: product})
    end
  end

  def make
    @recipe_id = params[:recipe_id]

    @item_entity_factory = ItemEntityFactory.new(@player_character, @user_item_factory, @quest_entity_factory)
    recipe_making_service = RecipeMakingServiceFactory.new(@item_entity_factory).build_by_recipe_id_and_player_id(@recipe_id, @player_character.id)
    @result = recipe_making_service.execute
  end

  def set_factories
    equipment_service_factory = EquipmentServiceFactory.new
    equipped_service_factory = EquippedServiceFactory.new(equipment_service_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_service_factory)
    @user_item_factory = UserItemFactory.new(equipped_list_service_factory)
    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(@user_item_factory)
    @quest_entity_factory = Quest::QuestEntityFactory.new(@player_character_factory, quest_condition_entity_factory)

    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end
