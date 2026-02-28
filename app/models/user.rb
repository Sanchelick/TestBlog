class User < ApplicationRecord
  attr_accessor :old_password, :remember_token, :admin_edit
#  enum :role, { basic: :basic, moderator: :moderator, admin: :admin }, suffix: :role
  has_secure_password validations: false

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validate :password_presence
  validates :password, confirmation: true, allow_blank: true, length: {minimum: 8, maximum: 30}
  validate :correct_old_password, on: :update, if: -> {password.present? && !admin_edit}
  
  validates :name, presence: true, length: {minimum: 5}
  validates :email, presence: true

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

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, "не верный"
    
  end

  def password_presence
    errors.add(:password, :blank) if password_digest.blank?
  end

  def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine.MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
