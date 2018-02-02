require_relative '../news_helpers/rss_helper'

class ESPN
  def initialize( date, word_count_min )
    @rss_url = 'http://www.espn.com/espn/rss/news'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse The ESPN RSS Feed

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate >= Time.parse(@date)
          word_count = RssHelper.get_word_count( item.link, '.article' )

          title = RssHelper.html_to_text(item.title)
          snippet = (RssHelper.html_to_text(item.description) == title) ? '' : RssHelper.html_to_text(item.description)
          
          if word_count > @word_count_min
            @results.push({
              'web_url': item.link,
              'title': title,
              'image_url': '',
              'snippet': snippet,
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