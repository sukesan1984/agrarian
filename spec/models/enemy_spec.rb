require 'rails_helper'

RSpec.describe Enemy, type: :model do
  it 'has_one :enemy_map test' do
    is_expected.to have_one(:enemy_map)
  end
end
