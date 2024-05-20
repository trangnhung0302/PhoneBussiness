class PasswordReset < ApplicationRecord
  TOKEN_TIMEOUT = 24.hours

  belongs_to :customer

  before_create :set_password_reset_token

  def set_password_reset_token
    self.token = SecureRandom.hex(10)[0..5]
    self.expired_at = Time.current + TOKEN_TIMEOUT
  end

  def password_reset_token_expired?
    return false unless token && expired_at

    expired_at < Time.current
  end
end
