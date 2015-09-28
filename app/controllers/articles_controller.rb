class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @articles = policy_scope(Article)
  end

  def show
    @commentable = @article
    @comments = @commentable.comments
    @comment = Comment.new
  end

  def new
    @article = Article.new
  end

  def edit
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    authorize @article
    if @article.save
      current_user.articles << @article
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      authorize @article
      current_user.articles << @article
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @article
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:title, :body, (:published if current_user.role == "editor"))
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to articles_path
  end
end
