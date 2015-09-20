class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :create, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      @article.comments << @comment
      flash[:notice] = "Comment has been submitted to the editor for approval."
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    authorize @comment
  end

  def update
    @comment = @article.comments.build(comment_params)
    authorize @comment
    if @comment.save
      @article.comments.delete(params[:id])
      flash[:notice] = "Comment was successfully updated."
      redirect_to @article
    else
      render :new
    end
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
