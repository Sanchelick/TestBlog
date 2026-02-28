module Internationalization
  extend ActiveSupport::Concern
  
  included do
    
    around_action :switch_locale

    private
    
    def switch_locale(&action)
      locale = locale_from_headers || I18n.default_locale
      
      I18n.with_locale locale, &action
    end

    def locale_from_headers
      locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^\w{2}/).first
      return locale if I18n.available_locales.map(&:to_s).include?(locale)
    end
  end
end
