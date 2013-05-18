class Translation < ActiveRecord::Base
  attr_accessible :key, :value, :locale
end
