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

require 'rails_helper'

RSpec.describe UserSkill, type: :model do
  it 'calculate skill increase rate' do
    expect(UserSkill.calculate_increase_rate(0.0, 0)).to eq 25.0 
    expect(UserSkill.calculate_increase_rate(0.0, 10)).to eq 50 
    expect(UserSkill.calculate_increase_rate(30.0, 30)).to eq 22.5
    expect(UserSkill.calculate_increase_rate(30.0, 40)).to eq 45 
    expect(UserSkill.calculate_increase_rate(0.0, 30)).to eq 100
  end
end
