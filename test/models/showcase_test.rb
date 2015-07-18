# == Schema Information
#
# Table name: showcases
#
#  id          :integer          not null, primary key
#  shop_id     :integer
#  resource_id :integer
#  cost        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class ShowcaseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
