# == Schema Information
#
# Table name: roads
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  road_length :integer
#

class Road < ActiveRecord::Base
end
