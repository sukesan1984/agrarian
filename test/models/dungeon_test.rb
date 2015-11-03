# == Schema Information
#
# Table name: dungeons
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  max_floor   :integer          default(0), not null
#  min_search  :integer          default(0), not null
#  max_search  :integer          default(0), not null
#

require 'test_helper'

class DugeonTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
