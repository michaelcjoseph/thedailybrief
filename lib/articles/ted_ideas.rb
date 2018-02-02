require_relative '../news_helpers/rss_helper'

class TedIdeas
  def initialize( date, word_count_min )
    @rss_url = [
      'http://ideas.ted.com/feed/',
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Ted Ideas RSS Feed
    
    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            article_url = (item.at('link')).text
            word_count = RssHelper.get_word_count( article_url, '.article-content' )

            if word_count > @word_count_min
              title = RssHelper.html_to_text(item.at('title').text)
              description = RssHelper.html_to_text(item.at('description').text)
              image_url = item.xpath('media:content/@url').text

              @results.push({
                'web_url': article_url,
                'title': RssHelper.html_to_text(title),
                'image_url': image_url,
                'snippet': description,
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