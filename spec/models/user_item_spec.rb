# == Schema Information
#
# Table name: user_items
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  item_id    :integer
#  count      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_items_on_player_id_and_item_id  (player_id,item_id)
#

require 'rails_helper'

RSpec.describe UserItem, type: :model do
  it { is_expected.to belong_to(:item) }
end

