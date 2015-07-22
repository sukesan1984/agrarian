# == Schema Information
#
# Table name: establishments
#
#  id                 :integer          not null, primary key
#  town_id            :integer
#  establishment_type :integer
#  establishment_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Establishment, type: :model do
  it 'belongs_to :towns test' do
    is_expected.to belong_to(:town)
  end
end

