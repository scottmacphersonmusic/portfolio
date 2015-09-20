class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      flash[:notice] = "Comment has been submitted to the editor for approval."
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  private

  def comment_params
    params.require(:comment).permit(
      :commenter_name, :commenter_email,
      :commenter_url, :content)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end
