# == Schema Information
#
# Table name: harvests
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  description     :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  item_ability_id :integer
#

class Harvest < ActiveRecord::Base
  belongs_to :item_ability
end
