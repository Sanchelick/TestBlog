class User < ApplicationRecord
  attr_accessor :old_password, :remember_token
  has_secure_password validations: false

  validate :password_presence

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    update_column :remember_token_digest, digest(remember_token)
  end

  def remember_token_authenticated?(remember_token)
    return false unless remember_token_digest.present?
    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

  def forget_me
    update_column :remember_token_digest, nil
    self.remember_token = nil
  end

  private

  def password_presence
    errors.add(:password, :blank) if  password_digest.blank?
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine.MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
