class Api::ArticlesController < Api::BaseController
	def index
    respond_with Article.get_news
  end

  def show
  end

  def show_article
    article = Article.update_views( params[:id] )
    redirect_to article.web_url
  end

  def update_views
  	article = Article.update_views( params[:id] )
  	respond_with article, json: article
  end

  def update_topic
    article = nil
    
    if params[:type] == 'topic'
      article = Article.update_topic( params[:id], params[:topic_id] )
    elsif params[:type] == 'subtopic'
      article = Article.update_subtopic( params[:id], params[:subtopic_id] )
    end

    respond_with article, json: article
  end
end