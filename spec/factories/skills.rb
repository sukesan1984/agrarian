# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :skill do
    name 'MyString'
    description 'MyString'
  end
end

