class Text < ActiveRecord::Base

  attr_accessible :key, :value
  belongs_to :page
end
