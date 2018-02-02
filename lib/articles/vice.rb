require_relative '../news_helpers/rss_helper'

class Vice
  def initialize( date, word_count_min )
    @rss_url = [
      'https://www.vice.com/en_us/rss',
      'https://www.vice.com/en_uk/rss',
      'https://sports.vice.com/en_us/rss',
      'https://thecreatorsproject.vice.com/en_us/rss',
      'http://i-d.vice.com/en_us/rss',
      'https://noisey.vice.com/en_us/rss',
      'https://news.vice.com/feed',
      'https://waypoint.vice.com/en_us/rss',
      'https://motherboard.vice.com/rss'
    ]
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Vice RSS Feed

    # Stop words to verify title with
    stop_words = [
      'in Trump\'s America',
    ]
    
    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if RssHelper.verify_date( item.at('pubDate').text ) 
            if item.at('pubDate').text >= Time.parse(@date)
              word_count = RssHelper.word_count( RssHelper.html_to_text(item.xpath('content:encoded').text) )
              title = RssHelper.html_to_text(item.at('title').text)

              if word_count > @word_count_min && RssHelper.verify_title(title, stop_words)
                article_url = item.at('link').text
                description = RssHelper.html_to_text(item.at('description').text)
                image_url = item.xpath('enclosure/@url').text

                @results.push({
                  'web_url': article_url,
                  'title': RssHelper.html_to_text(title),
                  'image_url': image_url,
                  'snippet': RssHelper.html_to_text(description),
                  'word_count': word_count
                })
              end
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