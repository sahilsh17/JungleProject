class User < ActiveRecord::Base
  has_secure_password
  validates :password, :length => {:minimum => 6}
  validates :password_confirmation, presence: true
  validates :email, presence: true,:uniqueness => { :case_sensitive => false }
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  
  def self.authenticate_with_credentials(email,password)
    
    if User.find_by(email: email.downcase.strip)&.authenticate(password)
      user = User.find_by(email: email.downcase.strip)
    else
      user = nil
    end
  end
end
