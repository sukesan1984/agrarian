# == Schema Information
#
# Table name: inns
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  rails       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Inn, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
