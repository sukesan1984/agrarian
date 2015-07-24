# == Schema Information
#
# Table name: gifts
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Gift, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
