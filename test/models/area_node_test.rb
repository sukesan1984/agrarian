# == Schema Information
#
# Table name: area_nodes
#
#  id         :integer          not null, primary key
#  area_id    :integer
#  node_point :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_area_nodes_on_area_id  (area_id)
#

require 'test_helper'

class AreaNodeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
