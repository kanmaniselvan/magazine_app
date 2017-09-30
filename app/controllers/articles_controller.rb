class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all.order('created_at asc')
  end

  def create
    @article = Article.save_article(create_params)

    redirect_to article_path(id: @article.id)

  rescue StandardError => e
    # Special handling for the tag name validation alone.
    # Rest of the exception messages are descriptive enough work fine.
    flash.now[:error] = e.message.gsub(/Validation failed: Name/, 'Validation failed: Tag name')

    # Build these two variables, which are necessary for retaining the information
    # entered by the user after error.
    @tags = create_params.delete(:tags)
    @article = Article.new(create_params.delete_if{|k, v| 'tags' == k })
    render :new
  end

  def show
    @article = Article.where(id: params[:id]).includes(:user, tags: :sub_tags).first

    if @article.blank?
      flash[:error] = 'Article not found for the specified URL.'

      redirect_to articles_path
    end
  end

  def search
    @articles = Article.perform_search_and_get_results(params[:q])

    if @article.blank?
      flash.now[:alert] = 'Articles not found for the specified search query.'
    end

    render :index
  end

  protected
  def create_params
    params.require(:article).permit(:title, :content, tags: {} ).tap do |param|
      param[:user_id] = current_user.id
    end.to_h
  end
end
