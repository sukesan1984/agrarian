require 'rails_helper'

RSpec.describe Resource, type: :model do
  it { is_expected.to have_one(:nature_field) }
  it { is_expected.to have_many(:showcases) }
  it { is_expected.to belong_to(:item) }
end
