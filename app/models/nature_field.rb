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

class NatureField < ActiveRecord::Base
  belongs_to :resource
  belongs_to :resource_action
end
