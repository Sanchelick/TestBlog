class ArticlesController < ApplicationController

  before_action :find_article, only: %i[show edit update destroy]

  def index
    @articles = Article.all
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments.order created_at: :desc
  end

  def new
    @article = Article.new
  end

  def create

    @article = Article.create article_params

    if @article.save
      flash[:success] = "Статья создана"
      redirect_to root_path
    else
      render :new
    end
    
  end

  def edit
  end

  def update
    if @article.update article_params
      flash[:success] = "Статья обновлена"
      redirect_to root_path
    else
      render :edit
    end
    
  end
  
  def destroy
    @article.destroy
    flash[:succsess] = "Статья удалена"
    redirect_to root_path
  end


  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def find_article
    @article = Article.find params[:id]
  end
  
end
