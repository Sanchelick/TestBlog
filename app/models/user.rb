class User < ApplicationRecord
  include Recoverable
  attr_accessor :old_password, :remember_token, :admin_edit

  generates_token_for :pasword_reset, expires_in: 60.minutes do
    password_salt&.last(10)
  end
#  enum :role, { basic: :basic, moderator: :moderator, admin: :admin }, suffix: :role
  has_secure_password validations: false

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validate :password_presence
  validates :password, confirmation: true, allow_blank: true, length: {minimum: 8, maximum: 30}
  validate :correct_old_password, on: :update, if: -> {password.present? && !admin_edit}
  
  validates :name, presence: true, length: {minimum: 5}
  validates :email, presence: true, 'valid_email_2/email': true

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
