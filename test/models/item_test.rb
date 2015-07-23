# == Schema Information
#
# Table name: items
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  item_type      :integer
#  item_type_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  purchase_price :integer
#  sell_price     :integer
#

require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
