require_relative '../news_helpers/rss_helper'

class PlanetMoney
  def initialize( date )
    @rss_url = 'http://www.npr.org/rss/rss.php?id=93559255'
    @date = date
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Planet Money Podcast RSS Feed
    feed = RssHelper.nokogiri_read_feed( @rss_url )

    # CSS Tags to find image url
    css_tags = ['.storytext', '.graphicwrapper', 'img']

    if feed
      # Iterate through each of the items in the RSS Feed
      feed.each do |item|
        link = item.at('link').text
        if item.at('pubDate').text >= Time.parse(@date)
          @results.push({
            'web_url': link,
            'title': RssHelper.html_to_text(item.at('title').text),
            'image_url': get_image_url(link, css_tags),
            'snippet': RssHelper.html_to_text(item.at('description').text),
            'duration': get_duration(link)
          })
        end
      end
    end
  end

  def get_image_url( link, css_tags )
    src = RssHelper.get_image(link, css_tags)

    if src == ''
      return ''
    else
      return 'https://www.npr.org' + src
    end
  end

  def get_duration( link )
    doc = RssHelper.get_html_content(link)
    duration = doc.at_css('.audio-module-duration').text

    time = duration.split(':')
    return time[0].to_i * 60 + time[1].to_i
  end

  def get_results
    return @results
  end
end