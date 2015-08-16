# == Schema Information
#
# Table name: recipes
#
#  id                 :integer          not null, primary key
#  required_item_id1  :integer
#  required_item_num1 :integer
#  required_item_id2  :integer
#  required_item_num2 :integer
#  required_item_id3  :integer
#  required_item_num3 :integer
#  required_item_id4  :integer
#  required_item_num4 :integer
#  required_item_id5  :integer
#  required_item_num5 :integer
#  product_item_id    :integer
#  product_item_num   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
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
      variable_item_num = "required_item_num#{recipe_number}"
      @required_items.push(
        Recipe::Item.new(send(variable_item_id), send(variable_item_num)))
    end

    return @required_items
  end
end
