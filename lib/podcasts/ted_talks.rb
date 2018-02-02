require_relative '../news_helpers/rss_helper'

class TedTalks
  def initialize( date )
    @rss_url = 'https://www.ted.com/talks/rss'
    @date = date
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Ted Talks RSS Feed
    feed = RssHelper.nokogiri_read_feed( @rss_url )

    if feed
      # Iterate through each of the items in the RSS Feed
      feed.each do |item|
        if item.at('pubDate').text >= Time.parse(@date)
          @results.push({
            'web_url': item.xpath('enclosure/@url').text,
            'title': RssHelper.html_to_text(item.at('title').text),
            'image_url': item.xpath("*[name()='itunes:image']/@href").text,
            'snippet': RssHelper.html_to_text(item.at('description').text),
            'duration': RssHelper.convert_duration_to_secs(item.xpath("*[name()='itunes:duration']").text)
          })
        end
      end
    end
  end

  def get_results
    return @results
  end
end