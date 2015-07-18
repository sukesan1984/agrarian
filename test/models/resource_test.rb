# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  recover_count    :integer
#  recover_interval :integer
#  max_count        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  name             :string(255)
#  item_id          :integer
#

require 'test_helper'

class ResourceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
