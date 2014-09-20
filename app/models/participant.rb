class Participant < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  attr_accessible :user, :event, :user_id, :event_id
  validates_uniqueness_of :user_id, scope: :event_id
end
