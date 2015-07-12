class NatureField < ActiveRecord::Base
  belongs_to :harvest
  belongs_to :resource
end
