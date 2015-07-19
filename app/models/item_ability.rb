# == Schema Information
#
# Table name: item_abilities
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ItemAbility < ActiveRecord::Base
  has_many :item_ability_lists
  has_one :harvest
end

