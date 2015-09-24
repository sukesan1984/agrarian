# == Schema Information
#
# Table name: areas
#
#  id         :integer          not null, primary key
#  area_type  :integer
#  type_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  enemy_rate :integer
#  enemy_num  :integer
#

class Area < ActiveRecord::Base
  has_one :area_node
end

