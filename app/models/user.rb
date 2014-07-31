class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  after_initialize :ensure_session_token

  has_many(
  :cats,
  :class_name => "Cat",
  :foreign_key => :user_id,
  :primary_key => :id
  )

  has_many(
    :rental_requests,
    :class_name => "CatRentalRequest",
    :foreign_key => :user_id,
    :primary_key => :id
  )

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    user.try(:is_password?, password) ? user : nil
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  def password=(unencrypted_password)
    if unencrypted_password.present?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def is_password?(unencrypted_password)
    BCrypt::Password.new(self.password_digest).is_password?(unencrypted_password)
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

end
