# == Schema Information
#
# Table name: recipes
#
#  id                   :integer          not null, primary key
#  required_item_id1    :integer
#  required_item_count1 :integer
#  required_item_id2    :integer
#  required_item_count2 :integer
#  required_item_id3    :integer
#  required_item_count3 :integer
#  required_item_id4    :integer
#  required_item_count4 :integer
#  required_item_id5    :integer
#  required_item_count5 :integer
#  product_item_id      :integer
#  product_item_count   :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  skill_id             :integer
#  difficulty           :integer
#

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'Recipe::Item' do
    recipe_item = Recipe::Item.new(1, 1)
    expect(recipe_item.item_id).to eq 1
    expect(recipe_item.count).to eq 1
  end
  it 'required_item and product_item' do
    recipe = Recipe.new(
      required_item_id1: 100001,
      required_item_count1: 2,
      required_item_id2: 100002,
      required_item_count2: 3,
      required_item_id3: 100003,
      required_item_count3: 2,
      required_item_id4: 100004,
      required_item_count4: 1,
      required_item_id5: 100005,
      required_item_count5: 2,
      product_item_id: 100006,
      product_item_count: 1)
    expect(recipe.required_items[0].item_id).to eq 100001
    expect(recipe.required_items[0].count).to eq 2
    expect(recipe.required_items[1].item_id).to eq 100002
    expect(recipe.required_items[1].count).to eq 3
    expect(recipe.required_items[2].item_id).to eq 100003
    expect(recipe.required_items[2].count).to eq 2
    expect(recipe.required_items[3].item_id).to eq 100004
    expect(recipe.required_items[3].count).to eq 1
    expect(recipe.required_items[4].item_id).to eq 100005
    expect(recipe.required_items[4].count).to eq 2
    expect(recipe.product_item.item_id).to eq 100006
    expect(recipe.product_item.count).to eq 1
  end

  it 'required_item and product_item2' do
    recipe = Recipe.new(
      required_item_id1: 100001,
      required_item_count1: 2,
      required_item_id2: 0,
      required_item_count2: 3,
      required_item_id3: 100003,
      required_item_count3: 2,
      required_item_id4: 0,
      required_item_count4: 1,
      required_item_id5: 100005,
      required_item_count5: 2,
      product_item_id: 100006,
      product_item_count: 1)
    expect(recipe.required_items[0].item_id).to eq 100001
    expect(recipe.required_items[0].count).to eq 2
    expect(recipe.required_items[1].item_id).to eq 100003
    expect(recipe.required_items[1].count).to eq 2
    expect(recipe.required_items[2].item_id).to eq 100005
    expect(recipe.required_items[2].count).to eq 2
  end
end
