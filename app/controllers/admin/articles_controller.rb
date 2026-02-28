class Admin::ArticlesController < ApplicationController
  include ZipLoader
  
  before_action :require_authentication
  before_action :user_is_admin?
  
  def index
    @pagy, @articles = pagy Article.order(created_at: :desc)
    respond_to do |format|
      format.html do
        @articles
      end
      format.zip do 
        respond_with_zipped(@articles)
      end
    end
  end
  
end
