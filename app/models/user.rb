class User < ActiveRecord::Base
  validates :username, :session_token, uniqueness: true

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :posts, foreign_key: :author_id

  has_many :subs, foreign_key: :moderator_id

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)

    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
