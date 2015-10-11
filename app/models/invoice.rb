class Invoice < ActiveRecord::Base
  attr_accessible :user_id, :status, :amount, :url
  belongs_to :user
end
