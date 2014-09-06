class Text < ActiveRecord::Base

  attr_accessible :key, :value, :page_id
  belongs_to :page

  def name
    key
  end
end
