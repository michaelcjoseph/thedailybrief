load 'news.rb'
require 'set'

class Article < ActiveRecord::Base
	validates :source, presence: true
	validates :date, presence: true
	validates :web_url, presence: true, uniqueness: true
	validates :title, presence: true, uniqueness: true
	validates :word_count, presence: true
	validates :views, presence: true

	def self.add_news
		# Run by scheduler/cron-job to update articles in DB

		news = NewsSources.new

		news.get_news().each do |i|
			Article.create(
				source: i[:source],
				date: i[:date],
				web_url: i[:web_url],
				title: i[:title],
				image_url: i[:image_url],
				snippet: i[:snippet],
				word_count: i[:word_count],
				topic_id: i[:topic_id],
        subtopic_id: i[:subtopic_id],
				views: 0
			)
		end
	end

	def self.delete_news
		# Run by scheduler/cron-job to delete articles that are over a week old
		# and have 0 views (keeps the DB from getting too large too quickly)

		recent_article = Article.all.order(date: :desc).limit(1)
    recent_date = recent_article[0].date

    return Article.where(date: (recent_date-365)..(recent_date-8)).where(views: 0).destroy_all
	end

	def self.update_views( id )
		# Updates views on an article - triggered when article is clicked on 
		# frontend

		article = Article.find( id )
		article.views += 1
		article.save
		return article
	end

	def self.update_topic( id, topic_id )
		# Updates topic on an article - triggered when admin updated topic from
		# frontend

		article = Article.find( id )

    if topic_id == '0'
      article.topic_id = nil
    else
		  article.topic_id = topic_id
    end

		article.save
		return article
	end

  def self.update_subtopic( id, subtopic_id )
    # Updates subtopic on an article - triggered when admin updated topic from
    # frontend

    article = Article.find( id )

    if subtopic_id == '0'
      article.subtopic_id = nil
    else
      article.subtopic_id = subtopic_id
    end

    article.save
    return article
  end

	def self.get_news
		# Pull all articles for both the Top Stories section and Latest section

		feed = Article.get_feed_articles(24)
		top = Article.get_top_articles(72, true)

		return [{
			feed: feed,
			top_stories: top
			}]
	end

	def self.get_recent_date( timerange )
		recent_article = Article.all.order(created_at: :desc).limit(1)
    return (recent_article[0].created_at.to_time - timerange.hours).utc.to_datetime
	end

	def self.get_feed_articles( timerange )
		return Article.where('created_at > ?', Article.get_recent_date(timerange))
	end

  def self.get_newsletter_articles( timerange, topic_id=nil )
    days_of_time = timerange == 'daily' ? 24 : 144

    return Article.get_top_articles( days_of_time, false, topic_id)
  end

	def self.get_top_articles( timerange, isNotEmail, topic_id=nil )
		# Pull the top articles in the given timerange starting from the 
		# created_at timestamp of the most recent article in the DB and going back
		# by x amount of hours where hours is specified by the timerange

    recent_date = Article.get_recent_date( timerange )

    if topic_id
      all_articles = Article.where(
        'created_at > ? AND topic_id = ?', recent_date, topic_id
      ).order(views: :desc, word_count: :desc)
    else
      all_articles = Article.where(
      	'created_at > ? AND word_count > ?', recent_date, 1500
      ).where.not('image_url' => '').order(views: :desc, word_count: :desc)
    end

    article_ids = []
    article_sources = []
    long_form_sources = Set[
    	'Farnam Street', 
    	'Buzzfeed', 
    	'New Yorker', 
    	'Economist', 
    	'The Guardian', 
    	'NY Times', 
    	'The Atlantic', 
    	'NPR'
    ]

    for article in all_articles
    	# Check that we don't already have 4 articles
      if article_ids.length < 4
        # Check if the article has been viewed by people
        # Prioritize articles that have been clicked by users
        if isNotEmail && article.views > 0
          article_ids.push(article.id)
          article_sources.push(article.source)
        # Check there is only one article from a source
      	elsif !(article_sources.include? article.source)
      		# Check if the article is over a 20 min read
  	    	if article.word_count > (17 * 250)
  	    		# If it is over a 20 min read, make sure it is from one of the most
  	    		# trusted sources
  	    		if long_form_sources.include? article.source
  	    			article_ids.push(article.id)
  	    			article_sources.push(article.source)
  	    		end
  	    	# If article is not over a 20 min read
  	    	else
  	    		article_ids.push(article.id)
  	    		article_sources.push(article.source)
  	    	end
      	end
      end
    end

    return Article.find(article_ids)
	end

  def self.get_training_data_articles
    return Article.where(
      'created_at > ? AND created_at < ?', 
      Article.get_recent_date(120), 
      Article.get_recent_date(24)
    )
  end
end