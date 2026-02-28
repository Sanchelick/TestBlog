class CommentsController < ApplicationController

  before_action :find_article!
  
  def create
    @comment = @article.comments.build comment_params

    if @comment.save
      flash[:success] = t('.success')
      redirect_to article_path(@article)
    else
      @comments = @article.comments.order created_at: :desc
      render "articles/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user&.id)
  end

  def find_article!
    @article = Article.find params[:article_id]
  end
end
