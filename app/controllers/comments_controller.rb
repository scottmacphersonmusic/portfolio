class CommentsController < ApplicationController
  before_action :set_article, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @article.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment has been submitted to the editor for approval."
      redirect_to @article
    else
      render :new
    end
  end

  def edit
    authorize @comment
  end

  def update
    @comment = @article.comments.build(comment_params)
    authorize @comment
    if @comment.save
      flash[:notice] = "Comment was successfully updated."
      redirect_to @article
    else
      render :new
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to @article, notice: 'Comment was successfully destroyed.'
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

  def set_comment
    @comment = @article.comments.find(params[:id])
  end
end
