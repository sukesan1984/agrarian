require 'rails_helper'

RSpec.describe Area, type: :model do
  it 'have_one :area_node test' do
    is_expected.to have_one(:area_node)
  end
end
