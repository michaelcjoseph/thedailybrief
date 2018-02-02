require_relative '../news_helpers/rss_helper'

class Reuters
  def initialize( date, word_count_min )
    @rss_url = [
      'http://feeds.reuters.com/news/artsculture', # Arts
      'http://feeds.reuters.com/reuters/businessNews', # Business
      'http://feeds.reuters.com/reuters/companyNews', # Company News
      'http://feeds.reuters.com/reuters/entertainment', # Entertainment
      'http://feeds.reuters.com/reuters/environment', # Environment
      'http://feeds.reuters.com/reuters/healthNews', # Health
      'http://feeds.reuters.com/news/wealth', # Money/Wealth
      'http://feeds.reuters.com/Reuters/PoliticsNews', # Politics
      'http://feeds.reuters.com/reuters/scienceNews', # Science
      'http://feeds.reuters.com/reuters/sportsNews', # Sports
      'http://feeds.reuters.com/reuters/technologyNews', # Technology
      'http://feeds.reuters.com/Reuters/domesticNews', # US News
      'http://feeds.reuters.com/Reuters/worldNews', # World News
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Reuters RSS Feed

    # CSS Tags to find image url
    css_tags = ['.related-photo', 'img']

    # Stop words to verify title with
    stop_words = ['UPDATE']

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            title = RssHelper.html_to_text(item.at('title').text)
            word_count = RssHelper.get_word_count( article_url, '#article-text' )

            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
              @results.push({
                'web_url': article_url,
                'title': title,
                'image_url': RssHelper.get_image(article_url, css_tags),
                'snippet': RssHelper.html_to_text(item.at('description').text),
                'word_count': word_count
              })
            end
          end
        end
      end
    end
  end

  def get_results
    return @results
  end
end