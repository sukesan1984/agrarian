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

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
