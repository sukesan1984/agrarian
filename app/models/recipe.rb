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
#

class Recipe < ActiveRecord::Base
  # レシピのマックス素材数(db定義に依存)
  RECIPE_COUNT = 5
  # inner class
  class Recipe::Item
    attr_reader :item_id, :count
    def initialize(item_id, count)
      @item_id = item_id
      @count = count
    end
  end

  def required_items
    if @required_items
      return @required_items
    end

    @required_items = []

    (1..RECIPE_COUNT).each do |recipe_number|
      variable_item_id = "required_item_id#{recipe_number}"
      variable_item_count = "required_item_count#{recipe_number}"
      item_id = send(variable_item_id)
      count = send(variable_item_count)
      # item_idが0の時は飛ばす
      if item_id != 0
        @required_items.push(Recipe::Item.new(item_id, count))
      end
    end

    return @required_items
  end

  def product_item
    if @product_item
      return @product_item
    end

    @product_item = Recipe::Item.new(self.product_item_id, self.product_item_count)
    return @product_item
  end
end
