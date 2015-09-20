class RecipeController < ApplicationController
  before_action :authenticate_user!
  before_action :set_factories
  before_action :set_player_character

  def index
    @recipe_list = self.create_recipe_list
  end

  def make
    @recipe_id = params[:recipe_id]

    recipe_making_service = RecipeMakingServiceFactory.new(@item_entity_factory).build_by_recipe_id_and_player_id(@recipe_id, @player_character.id)
    @result = recipe_making_service.execute
    @recipe_list = self.create_recipe_list
  end

  def create_recipe_list
    recipes = Recipe.all
    recipe_list = []
    recipes.each do |recipe|
      required_items = []
      recipe.required_items.each do |required_item|
        required_items.push(@item_entity_factory.build_by_player_id_and_item_id_and_count(@player_character.id, required_item.item_id, required_item.count))
      end
      product = @item_entity_factory.build_by_player_id_and_item_id_and_count(@player_character.id, recipe.product_item.item_id, recipe.product_item.count)
      recipe_list.push(id: recipe.id, required_items: required_items, product: product)
    end
    return recipe_list
  end
  
  def set_factories
    equipment_entity_factory = EquipmentEntityFactory.new
    equipped_entity_factory = EquippedEntityFactory.new(equipment_entity_factory)
    equipped_list_service_factory = EquippedListServiceFactory.new(equipped_entity_factory)
    @user_item_factory = UserItemFactory.new(equipped_list_service_factory)
    quest_condition_entity_factory = Quest::QuestConditionEntityFactory.new(@user_item_factory)
    @quest_entity_factory = Quest::QuestEntityFactory.new(@player_character_factory, quest_condition_entity_factory)

    @player_character_factory = PlayerCharacterFactory.new(equipped_list_service_factory)
    @item_entity_factory = ItemEntityFactory.new(@player_character_factory, @user_item_factory, @quest_entity_factory)
  end

  def set_player_character
    @player_character = @player_character_factory.build_by_user_id(current_user.id)
    redirect_to('/player/input') if @player_character.nil?
  end
end

