require 'rails_helper'

RSpec.describe UserEncounterEnemy, type: :model do
  it { is_expected.to belong_to(:enemy) }
end
