# == Schema Information
#
# Table name: user_banks
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  rails      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_banks_on_player_id  (player_id) UNIQUE
#

FactoryGirl.define do
  factory :user_bank do
    player_id 1
rails 1
  end

end
