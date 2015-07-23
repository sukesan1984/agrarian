# == Schema Information
#
# Table name: resource_keepers
#
#  id                :integer          not null, primary key
#  target_id         :integer
#  current_count     :integer
#  last_recovered_at :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  lock_version      :integer          default(0), not null
#  resource_id       :integer          default(1)
#
# Indexes
#
#  index_resource_keepers_on_target_id_and_resource_id  (target_id,resource_id) UNIQUE
#

require 'rails_helper'

RSpec.describe ResourceKeeper, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

