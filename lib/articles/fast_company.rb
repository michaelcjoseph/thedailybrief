require_relative '../news_helpers/rss_helper'

class FastCompany
  def initialize( date, word_count_min )
    @rss_url = 'https://feeds.feedburner.com/fastcompany/headlines'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse The Fast Company RSS Feed

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.pubDate >= Time.parse(@date)
          word_count = RssHelper.get_word_count( item.feedburner_origLink, '.article-content' )

          title = RssHelper.html_to_text(item.title)

          rss_description = RssHelper.html_to_text(item.description)
          snippet = (rss_description == title) ? '' : rss_description
          
          if word_count > @word_count_min
            @results.push({
              'web_url': item.feedburner_origLink,
              'title': title,
              'image_url': item.media_content_url,
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