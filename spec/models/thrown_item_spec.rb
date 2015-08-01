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
#  lock_version :integer          default(0), not null
#
# Indexes
#
#  index_thrown_items_on_area_node_id_and_item_id  (area_node_id,item_id) UNIQUE
#

require 'rails_helper'

RSpec.describe ThrownItem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
