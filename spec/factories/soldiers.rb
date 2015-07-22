# == Schema Information
#
# Table name: soldiers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  attack      :integer
#  defense     :integer
#  hp          :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :soldier do
  end
end

