require 'rails_helper'

RSpec.describe Town, type: :model do
  it { is_expected.to have_many(:town_bulletin_boards) }
  it { is_expected.to have_many(:establishments) }
end
