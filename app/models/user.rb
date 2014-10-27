class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@([\w\-]+\.)+[\w]+\z/i
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  # User. -> method for class, don't need a user instance to work
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Micropost.where("user_id = ?", id)
  end

  private
    # This method is used only to initiate the remember_token attribuite when create a new user
    def create_remember_token
      # self means this user's attribute which will be saved in database
      self.remember_token = User.digest(User.new_remember_token)
    end
end
