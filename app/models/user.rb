class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, :uniqueness => {:case_sensitive => false}
  validates :first_name, presence: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :last_name, presence: true

  has_many :reviews

  before_save do
    self.email.downcase! if self.email
  end

  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
