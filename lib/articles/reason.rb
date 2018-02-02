require_relative '../news_helpers/rss_helper'

class Reason
  def initialize( date, word_count_min )
    @rss_url = 'http://feeds.feedburner.com/reason/Articles'
    @date = date
    @word_count_min = word_count_min
    @results = []
    parse_feed() 
  end

  def parse_feed
    # Parse Reason RSS Feed

    # CSS Tags to find image url
    css_tags = ['.l-article-img', 'img']

    feed = RssHelper.read_feed( @rss_url )

    if feed
    # Iterate through each of the items in the RSS Feed
      feed.items.each do |item|
        if item.published >= Time.parse(@date)
          article_url = item.feedburner_origLink
          word_count = RssHelper.word_count( RssHelper.html_to_text(item.content) )
          
          if word_count > @word_count_min
            @results.push({
              'web_url': article_url,
              'title': RssHelper.html_to_text(item.title),
              'image_url': RssHelper.get_image(article_url, css_tags),
              'snippet': RssHelper.html_to_text(item.summary),
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