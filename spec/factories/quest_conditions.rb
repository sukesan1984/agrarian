# == Schema Information
#
# Table name: quest_conditions
#
#  id              :integer          not null, primary key
#  quest_id        :integer
#  target          :integer
#  condition_type  :integer
#  condition_id    :integer
#  condition_value :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :quest_condition do
    quest_id 1
target 1
condition_type 1
condition_id 1
condition_value 1
  end

end
