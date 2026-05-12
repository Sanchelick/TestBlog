
module Recoverable
  extend ActiveSupport::Concern

  included do
    before_update :clear_reset_password_token, if: :password_digest_changed?

    def clear_reset_password_token
      self.password_reset_token = nil
      self.password_reset_token_sent_at = nil
    end
  end
end
