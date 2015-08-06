# == Schema Information
#
# Table name: levels
#
#  id         :integer          not null, primary key
#  exp_min    :integer
#  exp_max    :integer
#  level      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_levels_on_level  (level)
#

class Level < ActiveRecord::Base
end
