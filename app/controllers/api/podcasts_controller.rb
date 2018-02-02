class Api::PodcastsController < Api::BaseController
  def index
    respond_with Podcast.get_podcasts
  end

  def show
  end

  def show_podcast
    podcast = Podcast.update_views( params[:id] )
    redirect_to podcast.web_url
  end

  def update_views
    podcast = Podcast.update_views( params[:id] )
    respond_with podcast, json: podcast
  end

  def update_topic
    podcast = nil
    
    if params[:type] == 'topic'
      podcast = Podcast.update_topic( params[:id], params[:topic_id] )
    elsif params[:type] == 'subtopic'
      podcast = Podcast.update_subtopic( params[:id], params[:subtopic_id] )
    end

    respond_with podcast, json: podcast
  end
end