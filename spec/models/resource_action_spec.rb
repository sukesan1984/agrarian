# == Schema Information
#
# Table name: resource_actions
#
#  id          :integer          not null, primary key
#  action_type :integer
#  action_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ResourceAction, type: :model do
  it { is_expected.to have_one(:nature_field) }
end

