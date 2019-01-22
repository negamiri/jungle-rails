class User < ActiveRecord::Base

  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: { minimum: 5 }
  before_save :downcase_email
  
  def self.authenticate_with_credentials(email, password)
    user = User.find_by(email: email.downcase.strip)
    user.authenticate(password)
  end

  def downcase_email
    self.email = email.downcase.strip
  end

end
