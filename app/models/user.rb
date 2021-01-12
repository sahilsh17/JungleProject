class User < ActiveRecord::Base
  has_secure_password
  validates :password, :length => {:minimum => 6}
  validates :password_confirmation, presence: true
  validates :email, presence: true
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

end
