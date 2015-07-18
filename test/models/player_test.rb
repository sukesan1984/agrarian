# == Schema Information
#
# Table name: players
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hp         :integer          default(50)
#  hp_max     :integer          default(50)
#  rails      :integer          default(300)
#
# Indexes
#
#  index_players_on_user_id  (user_id) UNIQUE
#

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
