# == Schema Information
#
# Table name: user_banks
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  rails      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_user_banks_on_player_id  (player_id) UNIQUE
#

require 'rails_helper'

RSpec.describe UserBank, type: :model do
  it 'increase' do
    user_bank = UserBank.new(player_id: 1, rails: 0)
    user_bank.add_rails(1)
    expect(user_bank.rails).to eq 1
    user_bank.add_rails(-3)
    expect(user_bank.rails).to eq 0
  end
end
