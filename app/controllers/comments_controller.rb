class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :create]
  before_action :authenticate_user!, only: [:edit, :update]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      @comment.approved = false
      @article.comments << @comment
      flash[:notice] = "Comment has been submitted to the editor for approval."
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
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
