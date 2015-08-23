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

FactoryGirl.define do
  factory :level do
    exp_min 1
    exp_max 1
    level 1
  end
end

