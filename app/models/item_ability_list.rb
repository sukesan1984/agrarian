# == Schema Information
#
# Table name: item_ability_lists
#
#  id              :integer          not null, primary key
#  item_id         :integer
#  item_ability_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ItemAbilityList < ActiveRecord::Base
  belongs_to :item_ability
  belongs_to :item
end

