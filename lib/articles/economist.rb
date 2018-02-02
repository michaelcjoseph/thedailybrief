require_relative '../news_helpers/rss_helper'

class Economist
  def initialize( date, word_count_min )
    @rss_url = [
      'http://www.economist.com/sections/business-finance/rss.xml',
      'http://www.economist.com/sections/economics/rss.xml',
      'http://www.economist.com/sections/science-technology/rss.xml',
      'http://www.economist.com/sections/culture/rss.xml',
      'http://www.economist.com/sections/united-states/rss.xml',
      'http://www.economist.com/sections/britain/rss.xml',
      'http://www.economist.com/sections/china/rss.xml',
      'http://www.economist.com/sections/americas/rss.xml',
      'http://www.economist.com/sections/middle-east-africa/rss.xml',
      'http://www.economist.com/sections/leaders/rss.xml',
      'http://www.economist.com/sections/international/rss.xml',
      'http://www.economist.com/sections/europe/rss.xml',
      'http://www.economist.com/sections/asia/rss.xml',
      'http://www.economist.com/blogs/buttonwood/index.xml',
      'http://www.economist.com/blogs/erasmus/index.xml',
      'http://www.economist.com/blogs/freeexchange/index.xml',
      'http://www.economist.com/blogs/gametheory/index.xml',
      'http://www.economist.com/blogs/prospero/index.xml',
      'http://www.economist.com/blogs/economist-explains/index.xml'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Economist RSS Feed

    # CSS Tags to find image url
    css_tags = ['.content-image-full', 'img']

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            word_count = RssHelper.get_word_count( article_url, '.main-content' )

            if word_count > @word_count_min
              @results.push({
                'web_url': article_url,
                'title': RssHelper.html_to_text(item.at('title').text),
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