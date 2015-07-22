# == Schema Information
#
# Table name: towns
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Town, type: :model do
  it { is_expected.to have_many(:town_bulletin_boards) }
  it { is_expected.to have_many(:establishments) }
end
