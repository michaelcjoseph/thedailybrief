require_relative '../news_helpers/rss_helper'

class FarnamStreet
  def initialize( date, word_count_min )
    @rss_url = 'https://www.farnamstreetblog.com/feed/'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Farnam Street Blog RSS Feed
    feed = RssHelper.nokogiri_read_feed( @rss_url )

    if feed
      feed.each do |item|
        if item.at('pubDate').text >= Time.parse(@date)
          word_count = RssHelper.word_count( RssHelper.html_to_text(item.xpath('content:encoded').text) )

          if word_count > @word_count_min
            title = RssHelper.html_to_text(item.at('title').text)
            article_url = item.at('link').text
            description = RssHelper.html_to_text(item.at('description').text)

            @results.push({
              'web_url': article_url,
              'title': RssHelper.html_to_text(title),
              'image_url': '',
              'snippet': RssHelper.html_to_text(description),
              'word_count': word_count
            })
          end
        end
      end
    end
  end

  def get_results
    return @results
  end
end