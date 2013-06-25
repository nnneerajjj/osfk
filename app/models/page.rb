class Page < ActiveRecord::Base
  attr_accessible :title, :content, :public
end
