# == Schema Information
#
# Table name: soldiers
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  attack      :integer
#  defense     :integer
#  hp          :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Soldier, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
