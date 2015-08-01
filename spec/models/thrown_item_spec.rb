# == Schema Information
#
# Table name: thrown_items
#
#  id           :integer          not null, primary key
#  area_node_id :integer
#  item_id      :integer
#  count        :integer
#  thrown_at    :datetime         default(NULL), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe ThrownItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
