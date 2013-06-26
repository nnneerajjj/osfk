class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :number, :lastname, :website
  # attr_accessible :title, :body

  has_many :topics

  def name
    name = "#{firstname} #{lastname}"
    return email if name.blank?
    name
  end

  def fullname
    return name if number.nil?
    "#{name} (#{number})"
  end
end
