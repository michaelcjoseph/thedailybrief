require_relative '../news_helpers/rss_helper'

class TechCrunch
  def initialize( date, word_count_min )
    @rss_url = 'http://feeds.feedburner.com/TechCrunch/'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse TechCrunch RSS Feed

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate >= Time.parse(@date)
          link = item.feedburner_origLink
          title = RssHelper.html_to_text(item.title)

          image = ''
          if item.media_content_url
            image = item.media_content_url
          end
          
          rss_description = RssHelper.html_to_text(item.description)
          snippet = (rss_description == title) ? '' : rss_description

          word_count = RssHelper.get_word_count( link, '.article-entry' )
          
          if word_count > @word_count_min
            @results.push({
              'web_url': link,
              'title': title,
              'image_url': image,
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