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
  def self.get_level_from(exp)
    level = Level.where("exp_min <= ? and exp_max >= ?", exp, exp)
    fail 'no level for this exp' unless level[0]
    return level[0].level
  end
end
