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

class UserProgress < ActiveRecord::Base
  def self. get_or_create(player_id, progress_type, progress_id)
    user_progress = UserProgress.find_by(player_id: player_id, progress_type: progress_type, progress_id: progress_id)
    if user_progress.nil?
      user_progress = UserProgress.create(
        player_id: player_id,
        progress_type: progress_type,
        progress_id: progress_id,
        count: 0
      )
    end
    return user_progress
  end
end

module ProgressType
  KillEnemy = 1
end
