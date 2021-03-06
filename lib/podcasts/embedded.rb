require_relative '../news_helpers/rss_helper'

class Embedded
  def initialize( date )
    @rss_url = 'https://www.npr.org/rss/podcast.php?id=510311'
    @date = date
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Embedded Podcast RSS Feed
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
            'duration': item.xpath("*[name()='itunes:duration']").text
          })
        end
      end
    end
  end

  def get_results
    return @results
  end
end