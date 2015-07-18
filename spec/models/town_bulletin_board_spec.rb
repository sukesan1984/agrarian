require 'rails_helper'

RSpec.describe TownBulletinBoard, type: :model do
  it { is_expected.to belong_to(:town) }
  it { is_expected.to belong_to(:player) }
end
