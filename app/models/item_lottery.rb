# == Schema Information
#
# Table name: item_lotteries
#
#  id                 :integer          not null, primary key
#  group_id           :integer
#  item_id            :integer
#  count              :integer
#  weight             :integer
#  composite_group_id :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ItemLottery < ActiveRecord::Base
  def has_composite_group_id
    return composite_group_id > 0
  end
end

