load 'podcasts.rb'

class Podcast < ActiveRecord::Base
  validates :source, presence: true
  validates :date, presence: true
  validates :web_url, presence: true, uniqueness: true
  validates :title, presence: true, uniqueness: true
  validates :duration, presence: true
  validates :views, presence: true

  def self.add_podcasts
    # Run by scheduler/cron-job to update podcasts in DB

    podcasts = PodcastSources.new

    podcasts.get_podcasts().each do |i|
      Podcast.create(
        source: i[:source],
        date: i[:date],
        web_url: i[:web_url],
        title: i[:title],
        image_url: i[:image_url],
        snippet: i[:snippet],
        duration: i[:duration],
        topic_id: i[:topic_id],
        subtopic_id: i[:subtopic_id],
        views: 0
      )
    end
  end

  def self.delete_podcasts
    # Run by scheduler/cron-job to delete podcasts that are over a week old
    # and have 0 views (keeps the DB from getting too large too quickly)

    recent_podcast = Podcast.all.order(date: :desc).limit(1)
    recent_date = recent_podcast[0].date

    return Podcast.where(date: (recent_date-365)..(recent_date-8)).where(views: 0).destroy_all
  end

  def self.update_views( id )
    # Updates views on a podcast - triggered when article is clicked on 
    # frontend

    podcast = Podcast.find( id )
    podcast.views += 1
    podcast.save
    return podcast
  end

  def self.update_topic( id, topic_id )
    # Updates topic on a podcast - triggered when admin updated topic from
    # frontend

    podcast = Podcast.find( id )

    if topic_id == '0'
      podcast.topic_id = nil
    else
      podcast.topic_id = topic_id
    end
    
    podcast.save
    return podcast
  end

  def self.update_subtopic( id, subtopic_id )
    # Updates subtopic on a podcast - triggered when admin updated topic from
    # frontend

    podcast = Podcast.find( id )

    if subtopic_id == '0'
      podcast.subtopic_id = nil
    else
      podcast.subtopic_id = subtopic_id
    end

    podcast.save
    return podcast
  end

  def self.get_podcasts
    # Pull all podcasts for both the Top Stories section and Latest section

    feed = Podcast.get_feed_podcasts(24)
    top = Podcast.get_top_podcasts(72)

    return [{
      feed: feed,
      top_podcasts: top
      }]
  end

  def self.get_recent_date( timerange )
    recent_podcast = Podcast.all.order(created_at: :desc).limit(1)
    return (recent_podcast[0].created_at.to_time - timerange.hours).utc.to_datetime
  end

  def self.get_feed_podcasts( timerange )
    return Podcast.where('created_at > ?', Podcast.get_recent_date(timerange))
  end

  def self.get_newsletter_podcasts( timerange, topic_id=nil )
    days_of_time = timerange == 'daily' ? 24 : 144

    return Podcast.get_top_podcasts( days_of_time, topic_id, 1)
  end

  def self.get_top_podcasts( timerange, topic_id=nil, limit=4 )
    # Pull the top podcasts in the given timerange starting from the 
    # created_at timestamp of the most recent podcast in the DB and going back
    # by x amount of hours where hours is specified by the timerange

    recent_date = Podcast.get_recent_date(timerange)

    if topic_id
      all_podcasts = Podcast.where(
        'created_at > ? AND topic_id = ?', 
        Podcast.get_recent_date(timerange),
        topic_id
        ).order(views: :desc, duration: :desc)
    else
      all_podcasts = Podcast.where('created_at > ?', Podcast.get_recent_date(timerange)
        ).order(views: :desc, duration: :desc)
    end

    podcast_ids = []
    podcast_sources = []

    for podcast in all_podcasts
      if podcast_ids.length < limit && !(podcast_sources.include? podcast.source)
        podcast_ids.push(podcast.id)
        podcast_sources.push(podcast.source)
      end
    end

    return Podcast.find(podcast_ids)
  end

  def self.get_training_data_podcasts
    return Podcast.where(
      'created_at > ? AND created_at < ?', 
      Podcast.get_recent_date(120), 
      Podcast.get_recent_date(24)
    )
  end
end