class ArticlesController < ApplicationController
  def new
    @article = Article.new
    @tags = { 1 => { name: '', sub_tags: [''] } }
  end

  def index
    @articles = Article.all.order('created_at asc').includes(:user, tags: :sub_tags)
  end

  def create
    @article = Article.save_article(create_params)

    redirect_to article_path(id: @article.id)

  rescue StandardError => e
    flash.now[:error] = e.message

    @tags = create_params.delete(:tags)
    @article = Article.new(create_params.delete_if{|k, v| 'tags' == k })
    render :new
  end

  def show
    @article = Article.where(id: params[:id]).includes(:user, tags: :sub_tags).first

    if @article.blank?
      flash.now[:error] = 'Article not found for the specified URL.'

      redirect_to articles_path
    end
  end

  def search
    @articles = Article.perform_search_and_get_results(params[:q])
    render :index
  end

  protected
  def create_params
    params.require(:article).permit(:title, :content, tags: {} ).tap do |param|
      param[:user_id] = current_user.id
    end.to_h
  end
end
