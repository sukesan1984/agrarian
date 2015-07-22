# == Schema Information
#
# Table name: establishments
#
#  id                 :integer          not null, primary key
#  town_id            :integer
#  establishment_type :integer
#  establishment_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :establishment do
  end
end

