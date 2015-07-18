require 'rails_helper'

RSpec.describe Player, type: :model do
  it { is_expected.to have_one(:user_area) }
  it { is_expected.to have_many(:town_bulletin_boards) }
  it { is_expected.to belong_to(:user) }
end
