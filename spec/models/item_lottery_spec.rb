# == Schema Information
#
# Table name: item_lotteries
#
#  id                 :integer          not null, primary key
#  group_id           :integer
#  item_id            :integer
#  count              :integer
#  weight             :integer
#  composite_group_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe ItemLottery, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
