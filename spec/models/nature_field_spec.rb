require 'rails_helper'

RSpec.describe NatureField, type: :model do
  it { is_expected.to belong_to(:resource) }
  it { is_expected.to belong_to(:resource_action) }
end
