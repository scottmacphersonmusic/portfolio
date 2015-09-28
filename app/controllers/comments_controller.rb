class CommentsController < ApplicationController
  before_action :load_commentable, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
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
    authorize @comment
    if @comment.update_attributes(comment_params)
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
      :commenter_name, :commenter_email, :approved,
      :commenter_url, :content, :commentable_id)
  end

  def load_commentable
    @resource, id = request.path.split('/')[1, 2]
    @commentable = @resource.singularize.classify.constantize.find(id)
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end
end
