class Upload < ActiveRecord::Base
  validates :file, attachment_presence: true

  attr_accessible :file_file_name

  before_save :generate_uuid

  def image?
    false
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
