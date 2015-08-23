# == Schema Information
#
# Table name: enemies
#
#  id                    :integer          not null, primary key
#  name                  :string(255)
#  attack                :integer
#  defense               :integer
#  hp                    :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  description           :string(255)
#  rails                 :integer
#  exp                   :integer
#  item_lottery_group_id :integer          default(0), not null
#  drop_item_rate        :integer          default(0), not null
#

require 'test_helper'

class EnemyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
