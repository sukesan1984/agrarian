# == Schema Information
#
# Table name: quests
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :string(255)
#  reward_gift_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :quest do
    name 'MyString'
    description 'MyString'
    reward_gift_id 1
  end
end

