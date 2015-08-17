class RecipeMakingServiceFactory
  def initialize
  end

  def build_by_recipe_id_and_player_id(recipe_id, player_id)
    recipe = Recipe.find_by(id: recipe_id)
    fail "recipe is not found for #{recipe_id}" unless recipe

    user_item_dictionary = Entity::Item::UserItemDictionary.new
    # TODO: まとめて取得したほうが効率いい
    recipe.required_items.each do |required_item|
      user_item = UserItem.find_or_create(player_id, required_item.item_id)
      user_item_dictionary.add(required_item.item_id, user_item)
    end

    product_user_item = UserItem.find_or_create(player_id, recipe.product_item.item_id)
    return RecipeMakingService.new(recipe, user_item_dictionary, product_user_item)
  end
end
