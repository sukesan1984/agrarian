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
#

class UserProgress < ActiveRecord::Base
end
