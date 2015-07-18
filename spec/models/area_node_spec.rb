require 'rails_helper'

RSpec.describe AreaNode, type: :model do
  it 'belong_to :area test' do
    is_expected.to belong_to(:area)
  end
  it 'has_one :user_area test' do
    is_expected.to have_one(:user_area)
  end
end
