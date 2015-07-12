class NatureField < ActiveRecord::Base
  belongs_to :resource
  belongs_to :resource_action
end
