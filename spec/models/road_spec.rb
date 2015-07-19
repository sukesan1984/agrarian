# == Schema Information
#
# Table name: roads
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  road_length :integer
#

require 'rails_helper'

RSpec.describe Road, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
