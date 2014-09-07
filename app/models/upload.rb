class Upload < ActiveRecord::Base
  validates :file, attachment_presence: true

  attr_accessible :file_file_name

  before_save :generate_uuid

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
