require_relative '../news_helpers/rss_helper'

class TheRead
  def initialize( date )
    @rss_url = 'http://feeds.podtrac.com/eL1krEll7iB4'
    @date = date
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse The Read Podcast RSS Feed (via iTunes)
    feed = RssHelper.nokogiri_read_feed( @rss_url )

    if feed
      # Iterate through each of the items in the RSS Feed
      feed.each do |item|
        if item.at('pubDate').text >= Time.parse(@date)
          @results.push({
            'web_url': item.xpath("feedburner:origLink").text,
            'title': RssHelper.html_to_text(item.at('title').text),
            'image_url': 'http://i1.sndcdn.com/avatars-000051152214-37az46-original.jpg',
            'snippet': RssHelper.html_to_text(item.at('description').text),
            'duration': ( RssHelper.convert_duration_to_secs(item.xpath("*[name()='itunes:duration']").text) )
          })
        end
      end
    end
  end

  def get_results
    return @results
  end
end