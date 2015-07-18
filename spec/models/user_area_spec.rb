require 'rails_helper'

RSpec.describe UserArea, type: :model do
  it { is_expected.to belong_to(:player) }
  it { is_expected.to belong_to(:area_node) }
end
