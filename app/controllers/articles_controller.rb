class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all.order('created_at asc').includes(:user)
  end

  def create
    @article = Article.create!(create_params)

    redirect_to article_path(id: @article.id)

  rescue StandardError => e
    flash.now[:error] = e.message
    @article = Article.new(create_params)

    render :new
  end

  def show
    @article = Article.where(id: params[:id]).first

    if @article.blank?
      flash.now[:error] = 'Article not found for the specified URL.'

      redirect_to articles_path
    end
  end

  def search

  end

  protected
  def create_params
    params.require(:article).permit(:title, :content).tap do |param|
      param[:user_id] = current_user.id
    end
  end
end
