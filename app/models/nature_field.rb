class NatureField < ActiveRecord::Base
  belongs_to :action
  belongs_to :resource
end
