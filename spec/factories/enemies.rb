# == Schema Information
#
# Table name: enemies
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  attack      :integer
#  defense     :integer
#  hp          :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :string(255)
#  rails       :integer
#

FactoryGirl.define do
  factory :enemy do
    
  end

end
