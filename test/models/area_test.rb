# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  area_type  :integer
#  type_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  enemy_rate :integer
#

require 'test_helper'

class AreaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
