# == Schema Information
#
# Table name: resources
#
#  id               :integer          not null, primary key
#  recover_count    :integer
#  recover_interval :integer
#  max_count        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  name             :string(255)
#  item_id          :integer
#

require 'rails_helper'

RSpec.describe Resource, type: :model do
  it { is_expected.to have_one(:nature_field) }
  it { is_expected.to have_many(:showcases) }
  it { is_expected.to belong_to(:item) }
end

