class CommentsController < ApplicationController
  before_action :load_commentable, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]

  def new
    @comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.build(comment_params)
    if @comment.save
      flash[:notice] = "Comment has been submitted to the editor for approval."
      redirect_to @commentable
    else
      render :new
    end
  end

  def edit
    authorize @comment
  end

  def update
    @comment = @commentable.comments.build(comment_params)
    authorize @comment
    if @comment.save
      redirect_to @commentable, notice: "Comment was successfully updated."
    else
      render :new
    end
  end

  def destroy
    authorize @comment
    @comment.destroy
    redirect_to @commentable, notice: 'Comment was successfully destroyed.'
  end

  private

  def comment_params
    params.require(:comment).permit(
      :commenter_name, :commenter_email,
      :commenter_url, :content, :commentable_id)
  end

  def load_commentable
    @resource, id = request.path.split('/')[1, 2]
    @commentable = @resouce.singularize.classify.constantize.find(id)
  end

  def set_comment
    puts params.inspect
    @comment = @commentable.comments.find(params[:commentable_id])
  end
end
