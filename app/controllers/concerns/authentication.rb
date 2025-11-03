module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def current_user
      user = session[:user_id].present? ? user_from_session : user_from_token
      @current_user = user
    end

    def user_from_session
      User.find_by(id: session[:user_id])
    end

    def user_from_token
      user = User.find_by(id: cookies.encrypted[:user_id])
      token = cookies.encrypted[:remember_token]
      return unless user&.remember_token_authenticated?(token)

      sing_in user
      user
    end

    def user_singed_in?
      current_user.present?
    end

    def sing_in(user)
      session[:user_id] = user.id
    end
    
    def sing_out
      forget current_user
      session.delete :user_id
      @current_user = nil
    end

    def remember(user)
      user.remember_me
      cookies.encrypted.permanent[:remember_token] = user.remember_token
      cookies.encrypted.permanent[:user_id] = user.id
    end

    def forget(user)
      user.forget_me
      cookies.delete :user_id
      cookies.delete :remember_token
    end

    def require_authentication
      return if user_singed_in?

      flash[:warning] = "Вы должны войти в систему"
    end

    def require_no_authentication
      return unless user_singed_in?

      flash[:warning] = "Вы должны выйти из системы"
    end

    helper_method :current_user, :user_singed_in?
    
  end
end
