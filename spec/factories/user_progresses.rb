# == Schema Information
#
# Table name: user_progresses
#
#  id            :integer          not null, primary key
#  progress_type :integer
#  progress_id   :integer
#  count         :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  player_id     :integer
#
# Indexes
#
#  index1  (player_id,progress_type,progress_id) UNIQUE
#

FactoryGirl.define do
  factory :user_progress do
    progress_type 1
progress_id 1
count 1
  end

end
