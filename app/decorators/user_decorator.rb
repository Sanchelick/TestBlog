class UserDecorator < Draper::Decorator
  delegate_all

  def gravatar(size: 60)
    email_hash = Digest::MD5.hexdigest email.strip.downcase
    "https://gravatar.com/avatar/#{email_hash}.jpg?s=#{size}"
  end

  def moderator_or_admin?
    role == "moderator" || role == "admin"
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
