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

require 'rails_helper'

RSpec.describe UserProgress, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

