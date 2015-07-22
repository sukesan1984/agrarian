# == Schema Information
#
# Table name: nature_fields
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  description        :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  resource_action_id :integer
#  resource_id        :integer
#

require 'rails_helper'

RSpec.describe NatureField, type: :model do
  it { is_expected.to belong_to(:resource) }
  it { is_expected.to belong_to(:resource_action) }
end

