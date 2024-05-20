class PasswordSetting < ApplicationRecord
  TOKEN_TIMEOUT = 24.hours

  belongs_to :customer

  before_create :set_password_setup_token

  def set_password_setup_token
    self.token = SecureRandom.hex(6)
    self.expired_at = Time.current + TOKEN_TIMEOUT
  end

  def password_setup_token_expired?
    return false unless token && expired_at

    expired_at < Time.current
  end
end
