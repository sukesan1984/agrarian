require 'rails_helper'

RSpec.describe EnemyMap, type: :model do
  it 'belongs_to :enemy test' do
    is_expected.to belong_to(:enemy)
  end
end
