class Provision < ActiveRecord::Base
  belongs_to :build, inverse_of: :provisions
end
