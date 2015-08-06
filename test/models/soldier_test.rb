# == Schema Information
#
# Table name: soldiers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  attack_min  :integer
#  defense_min :integer
#  hp_min      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attack_max  :integer
#  defense_max :integer
#  hp_max      :integer
#

require 'test_helper'

class SoldierTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
