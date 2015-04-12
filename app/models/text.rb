class Text < ActiveRecord::Base

  attr_accessible :key, :value, :page_id
  belongs_to :page

  def name
    key
  end

  def text
    HTMLEntities.new.decode(HTML::FullSanitizer.new.sanitize(value)).squish
  end
end
