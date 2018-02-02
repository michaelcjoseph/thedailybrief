require_relative '../news_helpers/rss_helper'

class BillSimmons
  def initialize( date )
    @rss_url = [
      'http://feeds.feedburner.com/thebillsimmonspodcast',
    ]
    @date = date
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Bill Simmons Podcast RSS Feeds

    @rss_url.each do |url|
      feed = RssHelper.nokogiri_read_feed( url )

      if feed
        feed.each do |item|
          if item.at('pubDate').text >= Time.parse(@date)
            title = RssHelper.html_to_text(item.at('title').text)

            if (title.include? 'Episode:') == false
              @results.push({
                'web_url': item.at('link').text,
                'title': title,
                'image_url': 'http://i1.sndcdn.com/artworks-000210589003-o3paoi-original.jpg',
                'snippet': RssHelper.html_to_text(item.at('description').text),
                'duration': RssHelper.convert_duration_to_secs(item.xpath("*[name()='itunes:duration']").text)
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