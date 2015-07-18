require 'rails_helper'

RSpec.describe Establishment, type: :model do
  it 'belongs_to :towns test' do
    is_expected.to belong_to(:town)
  end
end
