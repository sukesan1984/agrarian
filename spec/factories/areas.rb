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
#

FactoryGirl.define do
  factory :area do
  end
end

