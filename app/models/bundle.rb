class Bundle < ActiveRecord::Base
  has_many :builds, inverse_of: :bundle
end
