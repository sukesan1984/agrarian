require 'rails_helper'

RSpec.describe ResourceAction, type: :model do
  it { is_expected.to have_one(:nature_field) }
end
