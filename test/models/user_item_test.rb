# == Schema Information
#
# Table name: user_items
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  item_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  equipped   :integer          default(0)
#
# Indexes
#
#  index_user_items_on_player_id_and_item_id  (player_id,item_id)
#

require 'test_helper'

class UserItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
