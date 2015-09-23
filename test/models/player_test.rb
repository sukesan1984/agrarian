# == Schema Information
#
# Table name: players
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  name           :string(255)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  hp             :integer          default(50)
#  hp_max         :integer          default(50)
#  rails          :integer          default(300)
#  str            :integer          default(2), not null
#  dex            :integer          default(5), not null
#  vit            :integer          default(3), not null
#  ene            :integer          default(5), not null
#  remaing_points :integer          default(0), not null
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
