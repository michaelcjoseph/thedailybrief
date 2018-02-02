require_relative '../news_helpers/rss_helper'

class BBC
  def initialize( date, word_count_min )
    @rss_url = [
      'http://feeds.bbci.co.uk/news/world/rss.xml',
      'http://feeds.bbci.co.uk/news/uk/rss.xml',
      'http://feeds.bbci.co.uk/news/business/rss.xml',
      'http://feeds.bbci.co.uk/news/politics/rss.xml',
      'http://feeds.bbci.co.uk/news/health/rss.xml',
      'http://feeds.bbci.co.uk/news/education/rss.xml',
      'http://feeds.bbci.co.uk/news/science_and_environment/rss.xml',
      'http://feeds.bbci.co.uk/news/technology/rss.xml',
      'http://feeds.bbci.co.uk/news/entertainment_and_arts/rss.xml'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse BBC Articles RSS Feed

    # Stop words to verify title with
    stop_words = ['Newspaper headlines:']
    
    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = item.at('link').text
            title = RssHelper.html_to_text(RssHelper.html_to_text(item.at('title').text))
            word_count = RssHelper.get_word_count( article_url, "div[property='articleBody']" )

            if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
              title = RssHelper.html_to_text(item.at('title').text)
              snippet = RssHelper.html_to_text(item.at('description').text)
              image_url = item.xpath('media:thumbnail/@url').text

              @results.push({
                'web_url': article_url,
                'title': title,
                'image_url': image_url,
                'snippet': snippet,
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