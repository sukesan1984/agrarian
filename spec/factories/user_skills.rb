# == Schema Information
#
# Table name: user_skills
#
#  id          :integer          not null, primary key
#  player_id   :integer
#  skill_id    :integer
#  skill_point :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :user_skill do
    player_id 1
skill_id 1
skill_point 1
  end

end
