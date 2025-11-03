module ApplicationHelper

  def currently_at(current_page = "")
    render partial: "shared/menu", locals: {current_page: current_page}
  end

  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page
    css_class = current_page == title ? "has-text-white-bis" : "has-text-grey"
    
    options[:class] = if options[:class]
                        options[:class] + " " + css_class
                      else
                        css_class
                      end
                        
    link_to(title, url, options)
  end
  
end
