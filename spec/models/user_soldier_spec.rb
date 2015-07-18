require 'rails_helper'

RSpec.describe UserSoldier, type: :model do
  it { is_expected.to belong_to(:soldier) }
end
