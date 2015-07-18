require 'rails_helper'

RSpec.describe UserItem, type: :model do
  it { is_expected.to belong_to(:item) }
end
